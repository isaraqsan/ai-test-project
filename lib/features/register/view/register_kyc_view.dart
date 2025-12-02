import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/theme.dart';
import 'package:gibas/features/register/controller/register_kyc_controller.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/component/buttons.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/widgets/photo_picker.dart';
import 'package:image_picker/image_picker.dart';

class RegisterKycView extends GetView<RegisterKycController> {
  const RegisterKycView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterKycController>(
      init: RegisterKycController(),
      builder: (controller) {
        return BaseScaffold(
          contentMobile: _contentMobile(),
          resizeToAvoidBottomInset: true,
          title: 'Verifikasi Wajah',
        );
      },
    );
  }

  Widget _contentMobile() {
    return SingleChildScrollView(
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
                Dimens.marginVerticalLarge(),
                PhotoPicker(
                  label: 'Foto Selfie',
                  path: controller.selfieImage,
                  imageSource: ImageSource.camera,
                  cameraDevice: CameraDevice.front,
                  onChanged: (value) => controller.onSelfieImage(value),
                ),
                Dimens.marginVerticalXLarge(),
                Buttons.button(
                  title: 'Daftar',
                  onPressed: controller.onVerification,
                ),
                Dimens.marginVerticalXLarge(),
              ],
            ),
          ),
          Dimens.marginVerticalXXXLarge(),
        ],
      ),
    );
  }
}
