import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notificationc {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidinit = AndroidInitializationSettings("mipmap/ic_launcher");
    var iosInit = DarwinInitializationSettings();
    var initsettings =
        InitializationSettings(android: androidinit, iOS: iosInit);
    await flutterLocalNotificationsPlugin.initialize(initsettings);
  }
}

Future showTextNotification(
    {var id = 0,
    required String title,
    required String body,
    var payload,
    required FlutterLocalNotificationsPlugin fln}) async {
  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails("channelId", "channelName",
          playSound: true, importance: Importance.max, priority: Priority.high);
  var not = NotificationDetails(
      android: androidNotificationDetails, iOS: DarwinNotificationDetails());
  await fln.show(id, title, body, not);
}
