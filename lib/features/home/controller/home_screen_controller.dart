import 'dart:io';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gibas/shared/widgets/overlay/overlay_controller.dart';

class HomeScreenController extends GetxController {
  var selectedImage = Rx<File?>(null);
  var loading = false.obs;
  var generatedImages = <String>[].obs;
  var error = Rx<String?>(null);

  Stream<DocumentSnapshot>? _callbackStream;
  final ImagePicker _picker = ImagePicker();

  var currentPage = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    _signInAnonymously();

    // Listener loading untuk overlay
    ever(loading, (isLoading) {
      if (isLoading == true) {
        OverlayController.to.showLoading();
      } else {
        OverlayController.to.hide();
      }
    });
  }

  void setCurrentPage(int index) {
    currentPage.value = index;
  }

  Future<void> _signInAnonymously() async {
    Log.d('Signing in anonymously...');
    await FirebaseAuth.instance.signInAnonymously();
    Log.d('Signed in as ${FirebaseAuth.instance.currentUser?.uid}');
  }

  Future<void> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImage.value = File(picked.path);
      generatedImages.clear();
      error.value = null;
    }
  }

  Future<String> _uploadOriginalImage(File imageFile) async {
    if (!imageFile.existsSync()) {
      throw Exception('File does not exist: ${imageFile.path}');
    }

    final ref = FirebaseStorage.instance
        .ref()
        .child('originals/${DateTime.now().millisecondsSinceEpoch}.jpg');

    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }

  Future<Map<String, dynamic>> _generateAIImages(
      String imageUrl, String prompt) async {
    final callable = FirebaseFunctions.instance.httpsCallable('generateImages');
    final result =
        await callable.call({'imageUrl': imageUrl, 'prompt': prompt});
    return Map<String, dynamic>.from(result.data);
  }

  Future<void> handleGenerate({bool useDummy = false}) async {
    if (selectedImage.value == null) return;

    try {
      loading.value = true; // overlay tampil
      error.value = null;
      generatedImages.clear();

      Log.d('Uploading original image...');
      final originalUrl = await _uploadOriginalImage(selectedImage.value!);
      Log.d('Uploaded original URL: $originalUrl');

      if (useDummy) {
        // ---------------- DUMMY MODE ----------------
        await Future.delayed(const Duration(seconds: 2)); // simulasi delay
        generatedImages.assignAll([
          'https://picsum.photos/seed/1/400/400',
          'https://picsum.photos/seed/2/400/400',
          'https://picsum.photos/seed/3/400/400',
          'https://picsum.photos/seed/4/400/400',
        ]);
        error.value = null;
        Log.d('Dummy images generated.');
        return;
      }

      Log.d('Calling AI generateImages Cloud Function...');
      final response =
          await _generateAIImages(originalUrl, 'Instagram travel scene');
      Log.d('Response from function: $response');

      final status = response['status'];

      if (status == 'completed') {
        final images = List<String>.from(response['images'] ?? []);
        generatedImages.addAll(images);

        await FirebaseFirestore.instance.collection('ai_images').add({
          'originalUrl': originalUrl,
          'generatedUrls': images,
          'createdAt': DateTime.now().toIso8601String(),
        });
      } else if (status == 'processing') {
        final taskId = response['taskId'];
        if (taskId == null || taskId.toString().isEmpty) {
          throw Exception('Missing taskId from server');
        }

        Log.d('Waiting for callback... taskId = $taskId');
        _callbackStream = FirebaseFirestore.instance
            .collection('nanobanana_results')
            .doc(taskId)
            .snapshots();

        _callbackStream!.listen((snap) async {
          if (!snap.exists) return;
          final data = snap.data() as Map<String, dynamic>?;
          if (data == null) return;

          final images = List<String>.from(data['images'] ?? []);
          if (images.isNotEmpty) {
            generatedImages.assignAll(images);
            error.value = null;

            final uploadedUrls = await Future.wait(images.map((url) async {
              final httpResponse = await io.HttpClient().getUrl(Uri.parse(url));
              final response = await httpResponse.close();
              final bytes = await consolidateHttpClientResponseBytes(response);

              final ref = FirebaseStorage.instance.ref().child(
                  'generated/${DateTime.now().millisecondsSinceEpoch}.jpg');

              await ref.putData(bytes);
              return await ref.getDownloadURL();
            }));

            Log.d(
                'Uploaded generated images to Firebase Storage: $uploadedUrls');

            await FirebaseFirestore.instance.collection('ai_images').add({
              'originalUrl': originalUrl,
              'generatedUrls': uploadedUrls,
              'createdAt': DateTime.now().toIso8601String(),
            });
          }
        });

        error.value = 'Generating images... please wait.';
      } else {
        throw Exception('Unknown status returned: $status');
      }
    } catch (e, stack) {
      Log.e('Error in handleGenerate: $e\n$stack');
      error.value = e.toString();
    } finally {
      loading.value = false; // overlay hilang
    }
  }
}
