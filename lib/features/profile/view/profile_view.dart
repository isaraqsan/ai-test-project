import 'package:cached_network_image/cached_network_image.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/features/profile/domain/profile_menu.dart';
import 'package:gibas/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/shared/base_scaffold.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return BaseScaffold(
          usePaddingHorizontal: false,
          contentMobile: _contentMobile(),
        );
      },
    );
  }

  Widget _contentMobile() {
    return controller.obx(
      (state) {
        return RefreshIndicator(
          onRefresh: () async {
            await controller.onRefresh();
          },
          child: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                color: ColorPalette.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                children: [
                  // Profile Card
                  Material(
                    // elevation: 2,
                    borderRadius: BorderRadius.circular(16),
                    color: ColorPalette.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                      child: Column(
                        children: [
                          // Avatar
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 3),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const CircleAvatar(
                              radius: 48,
                              backgroundImage: CachedNetworkImageProvider(
                                'https://avatar.iran.liara.run/public/32',
                              ),
                              backgroundColor: ColorPalette.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state?.user?.name ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorPalette.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            state?.role?.name ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'chairil.semangat@example.com',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Menu List
                  ...controller.listMenu.map(
                    (menu) {
                      final isLogout = menu.profileMenuKey == ProfileMenuKey.logout;
                      return Material(
                        color: ColorPalette.secondary,
                        borderRadius: BorderRadius.circular(12),
                        elevation: 1,
                        shadowColor: Colors.black12,
                        child: ListTile(
                          onTap: () => controller.onClickMenu(menu.profileMenuKey),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          leading: Icon(
                            menu.icon,
                            color: isLogout ? Colors.red : ColorPalette.white,
                          ),
                          title: Text(
                            menu.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isLogout ? Colors.red.shade700 : ColorPalette.white,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      onLoading: const Center(
        child: CircularProgressIndicator(color: ColorPalette.primary),
      ),
      onError: (error) => Center(child: Text('Terjadi kesalahan: $error')),
      onEmpty: const Center(child: Text('Data profil tidak tersedia')),
    );
  }
}
