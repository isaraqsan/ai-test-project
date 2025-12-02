import 'package:gibas/core/app/constant/hive_key.dart';
import 'package:gibas/core/service/dio_service.dart';
import 'package:gibas/core/utils/debouncer.dart';
import 'package:gibas/features/auth/model/auth.dart';
import 'package:latlong2/latlong.dart';
import 'package:gibas/core/app/constant/role.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/core/service/database_service.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/features/auth/view/login_view.dart';
import 'package:gibas/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();
  String version = '';
  String build = '';
  String package = '';
  late Role role;
  late Auth auth;
  LatLng currentLocation = const LatLng(0, 0);
  final Debouncer debouncer = Debouncer(milliseconds: 1000);

  @override
  void onClose() {
    // disconnectBluetooth();
    super.onClose();
  }

  String setVersion(String value) => version = value;

  Future onRefresh() async {
    // await onSetAuth();
  }

  Future<bool> onSetAuth(Auth auth) async {
    final DatabaseService databaseService = Get.find();
    await databaseService.write(HiveKey.auth.key, auth.toJson());
    this.auth = auth;
    role = Role.admin;
    return true;
  }

  Future<bool> onCheckAuth() async {
    final DatabaseService databaseService = Get.find();
    final DioService dioService = Get.find();
    final bool hasToken = databaseService.hasData(HiveKey.token.key);
    final bool hasAuth = databaseService.hasData(HiveKey.auth.key);
    if (hasToken && hasAuth) {
      dioService.setAuthToken(await databaseService.read(HiveKey.token.key));
      auth = Auth.fromJson(await databaseService.read(HiveKey.auth.key));
      role = Role.fromCode(auth.role?.name);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onSetToken(String? token) async {
    if (token != null) {
      final DatabaseService databaseService = Get.find();
      final DioService dioService = Get.find();
      await databaseService.write(HiveKey.token.key, token);
      dioService.setAuthToken(await databaseService.read(HiveKey.token.key));
      return true;
    } else {
      return false;
    }
  }

  Future<bool> clear() async {
    final DatabaseService databaseService = Get.find<DatabaseService>();
    await databaseService.clearDatasource();
    version = '';
    await deleteTempDirectory();
    return true;
  }

  Future<void> onLogout() async {
    debouncer.run(() async {
      await clear();
      Get.offAll(() => const LoginView());
    });
  }

  void navDashboard() {
    switch (role) {
      case Role.implementor:
      case Role.headOffice:
      case Role.admin:
        Get.offAll(() => const DashboardView());
        break;
      default:
        Utils.toast('Anda tidak memiliki hak akses');
        break;
    }
  }

  void setLocation(LatLng location) {
    currentLocation = location;
    update();
  }

  Future<bool> deleteTempDirectory() async {
    try {
      final dir = await getTemporaryDirectory();
      dir.deleteSync(recursive: true);
      return true;
    } catch (e) {
      Log.e(e.toString());
      return false;
    }
  }
}
