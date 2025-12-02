// import 'package:flutter/material.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:gibas/core/service/env_service.dart';

// class OnesignalService {
//   Future<void> setup() async {
//     OneSignal.Debug.setAlertLevel(OSLogLevel.none);

//     OneSignal.initialize(EnvService().baseEndpoint);

//     OneSignal.Notifications.clearAll();

//     OneSignal.User.pushSubscription.addObserver((state) {
//       debugPrint(OneSignal.User.pushSubscription.optedIn.toString());
//       debugPrint(OneSignal.User.pushSubscription.id);
//       debugPrint(OneSignal.User.pushSubscription.token);
//       debugPrint(state.current.jsonRepresentation());
//     });

//     OneSignal.Notifications.addPermissionObserver((state) {
//       debugPrint('Has permission $state');
//     });

//     OneSignal.Notifications.addClickListener((event) {
//       debugPrint('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
//     });

//     OneSignal.InAppMessages.paused(true);

//     OneSignal.Notifications.requestPermission(true);
//   }
// }
