import 'package:gibas/core/app/controller/auth_controller.dart';
import 'package:gibas/features/home/view/home_screen.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashscreenController extends GetxController {
  late AuthController authController;
  String version = '';

  @override
  void onReady() async {
    await 2.delay();
    authController = Get.find<AuthController>();
    onSetVersion();
    checkSession();
    super.onReady();
  }

  Future<void> onSetVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    authController.setVersion(version);
    update();
  }

  void checkSession() async {
    final bool auth = await authController.onCheckAuth();
    if (auth) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }
}
