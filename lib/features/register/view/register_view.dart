import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/theme.dart';
import 'package:gibas/core/utils/size_config.dart';
import 'package:gibas/domain/usecase/textfield_validator.dart';
import 'package:gibas/features/register/controller/register_controller.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/component/buttons.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/_input_field.dart';
import 'package:gibas/shared/typography/typography_component.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (controller) {
        return BaseScaffold(
          contentMobile: _contentMobile(),
          contentTablet: _contentTablet(),
          resizeToAvoidBottomInset: true,
          title: 'Buat Akun',
        );
      },
    );
  }

  Widget _contentMobile() {
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dimens.marginVerticalXXLarge(),
            Container(
              padding: Dimens.marginContentHorizontal,
              margin: Dimens.marginContentHorizontal10,
              decoration: Component.shadow(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Dimens.marginVerticalXLarge(),
                  // TextComponent.textTitle(
                  //   'Buat Akun',
                  //   type: TextTitleType.xl3,
                  //   bold: true,
                  // ),
                  Dimens.marginVerticalLarge(),
                  InputField(
                    label: 'Nama',
                    controller: controller.name,
                    validator: TextFieldValidator.regular,
                    hint: 'Masukan Nama Lengkap',
                    keyboardType: TextInputType.text,
                    prefixIcon: CupertinoIcons.person,
                  ),
                  InputField(
                    label: 'Username/No Anggota',
                    controller: controller.memberNumber,
                    validator: TextFieldValidator.regular,
                    hint: 'Masukan Username/No Anggota',
                    keyboardType: TextInputType.text,
                    prefixIcon: CupertinoIcons.person_2,
                    autofillHints: const [AutofillHints.username],
                  ),
                  InputField(
                    label: 'No Telepon',
                    controller: controller.phoneNumber,
                    validator: TextFieldValidator.regular,
                    hint: 'Masukan E-Mail',
                    keyboardType: TextInputType.phone,
                    prefixIcon: CupertinoIcons.phone,
                    autofillHints: const [AutofillHints.telephoneNumber],
                  ),
                  InputField(
                    label: 'E-Mail',
                    controller: controller.email,
                    validator: TextFieldValidator.regular,
                    hint: 'Masukan E-Mail',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: CupertinoIcons.mail,
                  ),
                  InputField(
                    label: 'Password',
                    obscureText: controller.showPassword,
                    controller: controller.password,
                    validator: TextFieldValidator.regular,
                    hint: 'Masukan Password',
                    prefixIcon: CupertinoIcons.lock,
                    suffixIcon: controller.showPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                    onTapSuffix: controller.onChangeShowPassword,
                  ),
                  InputField(
                    label: 'Konfirmasi Password',
                    obscureText: controller.showPassword,
                    controller: controller.confirmPassword,
                    validator: TextFieldValidator.regular,
                    hint: 'Masukan Konfirmasi Password',
                    prefixIcon: CupertinoIcons.lock,
                    suffixIcon: controller.showPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                    onTapSuffix: controller.onChangeShowPassword,
                  ),
                  Dimens.marginVerticalXLarge(),
                  Buttons.button(
                    title: 'Selanjutnya',
                    onPressed: controller.onRegister,
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
                    const InputField(
                      label: 'Username',
                      // controller: controller.username,
                      validator: TextFieldValidator.regular,
                      hint: 'Masukan Username',
                      keyboardType: TextInputType.text,
                      prefixIcon: CupertinoIcons.person,
                      autofillHints: [AutofillHints.username],
                    ),
                    InputField(
                      label: 'Password',
                      obscureText: controller.showPassword,
                      // controller: controller.passwordController,
                      validator: TextFieldValidator.regular,
                      hint: 'Masukan Password',
                      prefixIcon: CupertinoIcons.lock,
                      suffixIcon: controller.showPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                      onTapSuffix: controller.onChangeShowPassword,
                      autofillHints: const [AutofillHints.password],
                    ),
                    Dimens.marginVerticalXLarge(),
                    Buttons.button(title: 'Login', onPressed: controller.onRegister),
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
