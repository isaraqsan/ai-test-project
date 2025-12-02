import 'package:gibas/app_bindings.dart';
import 'package:gibas/core/app/constant.dart';
import 'package:gibas/core/utils/error_handling.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/features/splashscreen/view/splashscreen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:gibas/core/app/app_config.dart';
import 'package:gibas/core/service/database_service.dart';
import 'package:gibas/core/service/dio_service.dart';
import 'package:gibas/core/service/env_service.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  await dotenv.load();
  // await initializeSentry();
  await initializeAndRunApp();
}

Future<void> initializeSentry() async {
  Log.v('Starting Sentry...', tag: 'SENTRY');
  await SentryFlutter.init(
    (options) {
      options.dsn = EnvService().sentry;
      options.beforeSend = ErrorHandling.beforeSendEvent;
    },
    appRunner: initializeAndRunApp,
  );
}

Future<void> initializeAndRunApp() async {
  await initServices();
  runApp(const MyApp());
}

Future initServices() async {
  Log.v('Starting all services...', tag: 'Services');

  // * System
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
    ),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting(AppConfig.dateLocale);
  // * Environment
  await Get.putAsync<DatabaseService>(() => DatabaseService().init(), permanent: true);
  await Get.putAsync<DioService>(() => DioService().init(), permanent: true);
  Log.v('All services started', tag: 'Services');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      title: Constant.aplicationName,
      theme: Component.theme(),
      initialBinding: AppBindings(),
      home: const SplashscreenView(),
    );
  }
}
