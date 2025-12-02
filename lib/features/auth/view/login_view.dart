import 'package:gibas/core/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/constant.dart';
import 'package:gibas/core/app/theme.dart';
import 'package:gibas/domain/usecase/textfield_validator.dart';
import 'package:gibas/features/auth/controller/login_cotroller.dart';

import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/component/buttons.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/_input_field.dart';
import 'package:gibas/shared/typography/_text_component.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return BaseScaffold(
          contentMobile: _contentMobile(),
          contentTablet: _contentTablet(),
          resizeToAvoidBottomInset: false,
        );
      },
    );
  }

  Widget _contentMobile() {
    return Center(
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      IconsPath.logoTransparent,
                    ),
                  ),
                  Dimens.marginHorizontalLarge(),
                  Expanded(
                    child: TextComponent.textTitle(
                      Constant.aplicationName,
                      type: TextTitleType.xxxl3,
                      bold: true,
                    ),
                  ),
                ],
              ),
            ),
            Dimens.marginVerticalXXLarge(),
            Container(
              padding: Dimens.marginContentHorizontal,
              margin: Dimens.marginContentHorizontal10,
              decoration: Component.shadow(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Dimens.marginVerticalXLarge(),
                  TextComponent.textTitle(
                    'Login',
                    type: TextTitleType.xl3,
                    bold: true,
                  ),
                  Dimens.marginVerticalLarge(),
                  InputField(
                    label: 'Username/No Anggota',
                    controller: controller.usernameController,
                    validator: TextFieldValidator.regular,
                    hint: 'Masukan Username',
                    keyboardType: TextInputType.text,
                    prefixIcon: CupertinoIcons.person,
                    autofillHints: const [AutofillHints.username],
                  ),
                  InputField(
                    label: 'Password',
                    obscureText: controller.showPassword,
                    controller: controller.passwordController,
                    validator: TextFieldValidator.regular,
                    hint: 'Masukan Password',
                    prefixIcon: CupertinoIcons.lock,
                    suffixIcon: controller.showPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                    onTapSuffix: controller.onChangeShowPassword,
                    autofillHints: const [AutofillHints.password],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: controller.onNavForgotPassword,
                      child: TextComponent.textTitle(
                        'Lupa Password?',
                        colors: ColorPalette.white,
                      ),
                    ),
                  ),
                  Dimens.marginVerticalXLarge(),
                  Buttons.button(title: 'Masuk', onPressed: controller.onLogin),
                  Dimens.marginVerticalMedium(),
                  Buttons.button(
                    title: 'Buat Akun',
                    onPressed: controller.onNavRegister,
                    backgroundColor: ColorPalette.blackText2,
                  ),
                  Dimens.marginVerticalXLarge(),
                ],
              ),
            ),
            Dimens.marginVerticalXXXLarge(),
          ],
        ),
      ),
    );
  }

  Widget _contentTablet() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 20),
      child: Center(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      IconsPath.logoTransparent,
                      height: Dimens.imageSizelarge,
                    ),
                    Dimens.marginHorizontalLarge(),
                    TextComponent.textTitle(
                      Constant.aplicationName,
                      type: TextTitleType.xxxl1,
                      bold: true,
                      colors: ColorPalette.primary,
                    ),
                  ],
                ),
              ),
              Dimens.marginVerticalXXLarge(),
              Container(
                padding: Dimens.marginContentHorizontal,
                margin: Dimens.marginContentHorizontal10,
                decoration: Component.shadow(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Dimens.marginVerticalXLarge(),
                    TextComponent.textTitle(
                      'Login',
                      type: TextTitleType.xl1,
                      bold: true,
                    ),
                    Dimens.marginVerticalLarge(),
                    InputField(
                      label: 'Username',
                      controller: controller.usernameController,
                      validator: TextFieldValidator.regular,
                      hint: 'Masukan Username',
                      keyboardType: TextInputType.text,
                      prefixIcon: CupertinoIcons.person,
                      autofillHints: const [AutofillHints.username],
                    ),
                    InputField(
                      label: 'Password',
                      obscureText: controller.showPassword,
                      controller: controller.passwordController,
                      validator: TextFieldValidator.regular,
                      hint: 'Masukan Password',
                      prefixIcon: CupertinoIcons.lock,
                      suffixIcon: controller.showPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                      onTapSuffix: controller.onChangeShowPassword,
                      autofillHints: const [AutofillHints.password],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: controller.onNavForgotPassword,
                        child: TextComponent.textTitle(
                          'Lupa Password?',
                        ),
                      ),
                    ),
                    Dimens.marginVerticalXLarge(),
                    Buttons.button(title: 'Login', onPressed: controller.onLogin),
                    Dimens.marginVerticalXLarge(),
                  ],
                ),
              ),
              Dimens.marginVerticalXXXLarge(),
            ],
          ),
        ),
      ),
    );
  }
}
