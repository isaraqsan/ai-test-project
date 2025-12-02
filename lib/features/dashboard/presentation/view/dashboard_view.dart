import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/widgets/bottom_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return BaseScaffold(
          usePaddingHorizontal: false,
          resizeToAvoidBottomInset: false,
          contentMobile: _contentMobile(controller),
        );
      },
    );
  }

  Widget _contentMobile(DashboardController controller) {
    return controller.obx(
      (state) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: controller.onPopInvokedWithResult,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: controller.pages[controller.index],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: ColorPalette.white,
              selectedFontSize: 12,
              iconSize: 25,
              currentIndex: controller.index,
              selectedItemColor: ColorPalette.primary,
              onTap: (index) => controller.changeTab(index),
              items: List.generate(
                state?.length ?? 0,
                (index) => BottomNavigationBarItem(
                  activeIcon: BottomIcon(
                    path: state?[index].icon ?? '',
                    isActive: true,
                  ),
                  icon: BottomIcon(path: state?[index].icon ?? ''),
                  label: state?[index].title ?? '',
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

