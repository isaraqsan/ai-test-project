import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:gibas/core/app/controller/auth_controller.dart';
import 'package:gibas/core/app/theme.dart';
import 'package:gibas/features/home/controller/home_controller.dart';
import 'package:gibas/features/member/view/member_view.dart';
import 'package:gibas/features/profile/view/profile_view.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/typography_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.background,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              IconsPath.logoTransparent,
              height: Dimens.iconSizeLarge,
              width: Dimens.iconSizeLarge,
            ),
            Dimens.marginHorizontalMedium(),
            TextComponent.textTitle(
              'GIBAS',
              bold: true,
              colors: ColorPalette.white,
            ),
          ],
        ),
      ),
      backgroundColor: ColorPalette.background,
      body: GetBuilder(
        init: HomeController(),
        builder: (controller) {
          return controller.obx(
            (state) {
              return SingleChildScrollView(
                padding: Dimens.marginContentHorizontal,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Dimens.marginVerticalLarge(),
                    Container(
                      padding: Dimens.paddingContentCard,
                      decoration: Component.shadow(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 2,
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
                            flex: 5,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextComponent.textTitle(
                                  controller.greeting(),
                                  colors: ColorPalette.white,
                                ),
                                Dimens.marginVerticalSmall(),
                                TextComponent.textTitle(
                                  AuthController.instance.auth.user?.name,
                                  type: TextTitleType.l3,
                                  bold: true,
                                ),
                                Dimens.marginVerticalXSmall(),
                                TextComponent.textTitle(
                                  'Ketua Cabang Arcamanik',
                                  type: TextTitleType.l3,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Dimens.marginVerticalLarge(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Container(
                            padding: Dimens.paddingContentCard,
                            decoration: Component.shadow(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextComponent.textTitle(
                                  30.toString(),
                                  bold: true,
                                  type: TextTitleType.xl3,
                                ),
                                Dimens.marginVerticalMedium(),
                                TextComponent.textTitle(
                                  'Anggota',
                                  type: TextTitleType.m3,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Dimens.marginHorizontalMedium(),
                        Expanded(
                          child: Container(
                            padding: Dimens.paddingContentCard,
                            decoration: Component.shadow(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextComponent.textTitle(
                                  18.toString(),
                                  bold: true,
                                  type: TextTitleType.xl3,
                                ),
                                Dimens.marginVerticalMedium(),
                                TextComponent.textTitle(
                                  'Approval',
                                  type: TextTitleType.m3,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Dimens.marginVerticalLarge(),
                    TextComponent.textTitle(
                      'Menu',
                      bold: true,
                      colors: ColorPalette.white,
                    ),
                    Dimens.marginVerticalMedium(),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Get.to(() => const ProfileView()),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: Component.shadow(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    CupertinoIcons.person,
                                    color: ColorPalette.white,
                                  ),
                                  Dimens.marginVerticalSmall(),
                                  TextComponent.textBody(
                                    'Profil',
                                    colors: ColorPalette.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Dimens.marginHorizontalMedium(),
                        Expanded(
                          child: InkWell(
                            onTap: () => Get.to(() => const MemberView()),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: Component.shadow(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    CupertinoIcons.person_2,
                                    color: ColorPalette.white,
                                  ),
                                  Dimens.marginVerticalSmall(),
                                  TextComponent.textBody(
                                    'Anggota',
                                    colors: ColorPalette.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Dimens.marginHorizontalMedium(),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: Component.shadow(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  CupertinoIcons.person_add,
                                  color: ColorPalette.white,
                                ),
                                Dimens.marginVerticalSmall(),
                                TextComponent.textBody(
                                  'Approval',
                                  colors: ColorPalette.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        Dimens.marginHorizontalMedium(),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: Component.shadow(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  CupertinoIcons.gear,
                                  color: ColorPalette.white,
                                ),
                                Dimens.marginVerticalSmall(),
                                TextComponent.textBody(
                                  'Pengaturan',
                                  colors: ColorPalette.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Dimens.marginVerticalMedium(),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: Component.shadow(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  CupertinoIcons.news,
                                  color: ColorPalette.white,
                                ),
                                Dimens.marginVerticalSmall(),
                                TextComponent.textBody(
                                  'Berita',
                                  colors: ColorPalette.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        Dimens.marginHorizontalMedium(),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: Component.shadow(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  CupertinoIcons.home,
                                  color: ColorPalette.white,
                                ),
                                Dimens.marginVerticalSmall(),
                                TextComponent.textBody(
                                  'Cabang',
                                  colors: ColorPalette.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        Dimens.marginHorizontalMedium(),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: Component.shadow(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  CupertinoIcons.phone,
                                  color: ColorPalette.white,
                                ),
                                Dimens.marginVerticalSmall(),
                                TextComponent.textBody(
                                  'Bantuan',
                                  colors: ColorPalette.white,
                                )
                              ],
                            ),
                          ),
                        ),
                        Dimens.marginHorizontalMedium(),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: Component.shadow(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  CupertinoIcons.arrow_right_square,
                                  color: ColorPalette.white,
                                ),
                                Dimens.marginVerticalSmall(),
                                TextComponent.textBody(
                                  'Keluar',
                                  colors: ColorPalette.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Dimens.marginVerticalLarge(),
                    TextComponent.textTitle(
                      'Berita',
                      bold: true,
                      colors: ColorPalette.white,
                    ),
                    Dimens.marginVerticalMedium(),
                    Flexible(
                      child: ListView.separated(
                        itemCount: state?.length ?? 0,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) => cardProgram(index),
                        separatorBuilder: (context, index) => const Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: ColorPalette.grey,
                          ),
                        ),
                      ),
                    ),
                    Dimens.marginVerticalLarge(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget cardProgram(int index) {
    return InkWell(
      // onTap: () => controller.onClickProgram(index),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: controller.state?[index].image ?? '',
              ),
            ),
          ),
          Dimens.marginHorizontalMedium(),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponent.textTitle(
                  controller.state?[index].title ?? '',
                  maxLines: 1,
                  bold: true,
                  colors: ColorPalette.white,
                ),
                Dimens.marginVerticalXSmall(),
                TextComponent.textBody(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  colors: ColorPalette.white,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
