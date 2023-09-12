import 'package:build/model/firebase_api.dart';
import 'package:build/view/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Color maincolor = const Color(0xff4C2963);
Color pinkcolor = const Color(0xffAA277B);
Color greencolor = const Color(0xff21E900);

bool isSign = false;
//0=arabic , 1=english
int language = 0;
late double deviceHeight;
late double deviceWidth;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo',
        primaryColor: maincolor,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: maincolor, primary: maincolor),
      ),
      home: const Splash(),
    );
  }
}
       //when i awant to send noti
          //in init state put :
         //  Notificationc.initialize(flutterLocalNotificationsPlugin);
         //in onTap put
         /* showTextNotification(
              title: "this is title message",
              body: "this is body message",
              fln: flutterLocalNotificationsPlugin);*/
