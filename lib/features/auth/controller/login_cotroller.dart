import 'package:gibas/core/app/constant/role.dart';
import 'package:gibas/core/app/controller/auth_controller.dart';
import 'package:gibas/features/auth/model/auth.dart';
import 'package:gibas/features/auth/repository/auth_repository.dart';
import 'package:gibas/features/home/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/features/register/view/register_view.dart';

class LoginController extends GetxController {
  late AuthRepository authRepository;
  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = true;

  @override
  void onReady() {
    authRepository = AuthRepository();
    super.onReady();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  Future<void> onLogin() async {

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
    // final LoginRequest loginRequest = LoginRequest(
    //   username: usernameController.text,
    //   password: passwordController.text,
    // );
    // await authRepository.login(loginRequest).then(
    //   (value) async {
    //     if (value.isSuccess) {
    //       await AuthController.instance.onSetToken(value.data?.accessToken);
    //       final resultAuth = await authRepository.profile();
    //       if (resultAuth.isSuccess) {
    //         await AuthController.instance.onSetAuth(resultAuth.data!);
    //         Get.to(() => const MasterActionView());
    //       }
    //     }
    //   },
    // );
  }

  Future<void> onNavForgotPassword() async {
    // Get.to(() => const ForgotPasswordView(), transition: Transition.fade);
  }

  Future<void> onNavRegister() async {
    Get.to(() => const RegisterView(), transition: Transition.fade);
  }
}
