import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/core/utils/size_config.dart';
import 'package:gibas/shared/component/buttons.dart';
import 'package:gibas/shared/typography/_text_component.dart';
import 'package:gibas/shared/widgets/overlay/animated_loading_logo.dart';

class StateWidget {
  static Widget emptyData({String? message, bool fitheight = false}) {
    return Container(
      height: fitheight ? SizeConfig.blockSizeVertical * 80 : null,
      alignment: Alignment.center,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox_rounded,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 12),
            Text(
              'Tidak ada data',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message ?? 'Data belum tersedia saat ini',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget emptyFilter() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.inbox_rounded,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 12),
          Text(
            'Tidak ada data',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Data belum tersedia saat ini',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  static Container loadingWhite() {
    return Container(
      decoration: const BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Widget loading() {
    return const Center(
      child: AnimatedLoadingIcon(),
    );
  }

  static Widget gpsDisabled({Function? onRefresh}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            CupertinoIcons.location_slash_fill,
            size: Dimens.imageSizelarge,
            color: ColorPalette.white,
          ),
          Dimens.marginVerticalXLarge(),
          TextComponent.textTitle(
            'GPS tidak aktif',
            type: TextTitleType.xl3,
          ),
          Dimens.marginVerticalLarge(),
          const SizedBox(height: 4),
          TextComponent.textBody(
            'Silahkan aktifkan GPS terlebih dahulu',
            textAlign: TextAlign.center,
            type: TextBodyType.l3,
          ),
          Dimens.marginVerticalLarge(),
          Buttons.whiteBackgorund(
            title: 'Refresh',
            onPressed: () {
              if (onRefresh != null) {
                onRefresh();
              }
            },
          ),
        ],
      ),
    );
  }
}
