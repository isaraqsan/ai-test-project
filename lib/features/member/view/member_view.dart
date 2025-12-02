import 'package:cached_network_image/cached_network_image.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/constant/icons_path.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/features/member/controller/member_controller.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/_input_field.dart';
import 'package:gibas/shared/typography/_text_component.dart';
import 'package:gibas/shared/widgets/chip_button_horizontal.dart';
import 'package:gibas/shared/widgets/shimmer.dart';
import 'package:gibas/shared/widgets/state_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MemberView extends GetView<MemberController> {
  const MemberView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MemberController(),
      builder: (controller) {
        return BaseScaffold(
          title: 'Anggota',
          usePaddingHorizontal: false,
          contentMobile: _contentMobile(),
          onTapFab: controller.onNavAdd,
        );
      },
    );
  }

  Widget _contentMobile() {
    return controller.obx(
      (state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: Dimens.marginContentHorizontal,
              child: InputField(
                hint: 'Cari anggota',
                prefixIcon: CupertinoIcons.search,
                onChanged: controller.onSearch,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: ChipButtonHorizontal(
                initialValue: controller.selectedFilter,
                listContent: controller.optionsFilter,
                onChanged: controller.onSelectFilter,
              ),
            ),
            Dimens.marginVerticalMedium(),
            Flexible(
              child: PagedListView(
                shrinkWrap: true,
                pagingController: controller.pagingController,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                builderDelegate: PagedChildBuilderDelegate(
                  animateTransitions: true,
                  itemBuilder: (_, item, index) => _cardOutlet(index),
                  firstPageProgressIndicatorBuilder: (context) => ShimmerWidget.loadingListWithPhoto(),
                  noItemsFoundIndicatorBuilder: (context) => StateWidget.emptyData(fitheight: true),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _cardOutlet(int index) {
    return InkWell(
      onTap: () => controller.onClickOutlet(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4, top: 4, left: 16, right: 16),
        padding: Dimens.paddingCardListMobile,
        decoration: Component.shadow(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: IconsPath.avatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Dimens.marginHorizontalLarge(),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent.textTitle(
                    '${controller.pagingController.itemList?[index].name}',
                    bold: true,
                    colors: ColorPalette.white,
                  ),
                  Dimens.marginVerticalSmall(),
                  TextComponent.textTitle(
                    '${controller.pagingController.itemList?[index].phone}',
                    colors: ColorPalette.white,
                  ),
                  Dimens.marginVerticalSmall(),
                  TextComponent.textTitle(
                    '${controller.pagingController.itemList?[index].department}',
                    colors: ColorPalette.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
