import 'dart:io';

import 'package:get/get.dart';
import 'package:gibas/core/app/constant/role.dart';
import 'package:gibas/core/app/controller/auth_controller.dart';
import 'package:gibas/features/auth/model/auth.dart';
import 'package:gibas/features/home/view/home_view.dart';

class RegisterKycController extends GetxController {
  String? selfieImage;

  void onSelfieImage(File? image) {
    selfieImage = image?.path;
    update();
  }

  void onVerification() {
    AuthController.instance.onSetAuth(
      Auth(
        role: RoleAuth(id: 1, name: Role.admin.name),
        user: User(
          name: 'Chairil Rafi Purnama',
          username: 'chairilrafipurnama',
        ),
      ),
    );
    Get.to(() => const HomeView());
  }
}
