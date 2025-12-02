import 'package:gibas/core/app/constant/hive_key.dart';
import 'package:gibas/core/app/controller/auth_controller.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/features/auth/model/auth.dart';
import 'package:gibas/features/auth/repository/auth_repository.dart';
import 'package:gibas/features/profile/domain/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/service/database_service.dart';

import 'package:gibas/shared/utils/dialog_helper.dart';

class ProfileController extends GetxController with StateMixin<Auth> {
  List<ProfileMenu> listMenu = [
    ProfileMenu(title: 'Ubah Profile', icon: Icons.manage_accounts, profileMenuKey: ProfileMenuKey.edit),
    ProfileMenu(title: 'Password', icon: Icons.password, profileMenuKey: ProfileMenuKey.password),
    ProfileMenu(title: 'Rate', icon: Icons.thumb_up, profileMenuKey: ProfileMenuKey.rate),
    ProfileMenu(title: 'Logout', icon: Icons.exit_to_app, profileMenuKey: ProfileMenuKey.logout),
  ];
  late DatabaseService databaseService;

  @override
  void onReady() {
    databaseService = Get.find<DatabaseService>();
    onGetProfile();
    super.onReady();
  }

  Future<void> onGetProfile() async {
    //* get from
    final auth = await databaseService.read(HiveKey.auth.key);
    change(Auth.fromJson(auth), status: RxStatus.success());
  }

  Future<void> onRefresh() async {
    final AuthRepository authRepository = AuthRepository();
    final result = await authRepository.profile();
    if (result.isSuccess) {
      await AuthController.instance.onSetAuth(result.data!);
      change(result.data, status: RxStatus.success());
    }
  }

  Future<void> onClickMenu(ProfileMenuKey profileMenuKey) async {
    switch (profileMenuKey) {
      case ProfileMenuKey.logout:
        final confirm = await DialogHelper.confirm(title: 'Logout', message: 'Apakah anda yakin ingin logout?');
        if (confirm ?? false) {
          AuthController.instance.onLogout();
        }
        break;
      case ProfileMenuKey.pjp:
      // Get.to(() => SetupPjpView());
      default:
        Utils.toast('Feature belum tersedia');
        break;
    }
  }
}
