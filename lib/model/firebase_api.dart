import 'dart:developer';

import 'package:build/controller/constant.dart';
import 'package:build/main.dart';
import 'package:build/model/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(message) async {
  Notificationc.initialize(flutterLocalNotificationsPlugin);
  showTextNotification(
      title: message.notification?.title ?? "",
      body: message.notification?.body ?? "",
      fln: flutterLocalNotificationsPlugin);
}

class FirebaseApi {
  final fireabsemessaging = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    try {
      final fsmToken = await fireabsemessaging.getToken();
      notificationToken = fsmToken;
      log(notificationToken.toString());
      /*  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }*/
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
      FirebaseMessaging.onMessage.listen((message) {
        Notificationc.initialize(flutterLocalNotificationsPlugin);
        showTextNotification(
            title: message.notification?.title ?? "",
            body: message.notification?.body ?? "",
            fln: flutterLocalNotificationsPlugin);
      });
    } catch (_) {}
  }
}
