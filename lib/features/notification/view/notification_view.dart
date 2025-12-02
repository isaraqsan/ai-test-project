import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/features/notification/controller/notification_controller.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/typography/typography_component.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (controller) {
        return BaseScaffold(
          usePaddingHorizontal: false,
          contentMobile: _contentMobile(),
        );
      },
    );
  }

  Widget _contentMobile() {
    return Container(
      color: ColorPalette.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.notifications,
              size: Dimens.imageSizeSmall,
              color: ColorPalette.primary,
            ),
            Dimens.marginVerticalMedium(),
            TextComponent.textTitle(
              'Belum ada notifikasi',
              textAlign: TextAlign.center,
              type: TextTitleType.l1,
            ),
          ],
        ),
      ),
    );
  }
}
