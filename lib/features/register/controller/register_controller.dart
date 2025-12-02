import 'package:flutter/material.dart' show GlobalKey, FormState, TextEditingController;
import 'package:get/get.dart';
import 'package:gibas/features/register/view/register_kyc_view.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final memberNumber = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool showPassword = true;

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void onRegister() {
    Get.to(() => const RegisterKycView());
  }

}
