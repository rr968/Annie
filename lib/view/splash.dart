// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:build/model/pricing.dart';
import 'package:build/model/services.dart';
import 'package:build/view/mainpage.dart';
import 'package:build/controller/no_imternet.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/constant.dart';
import '../controller/helper.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

class Splash extends StatefulWidget {
  final int mainPageIndex;
  const Splash({super.key, this.mainPageIndex = 0});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int seconds = 100;

  Future<void> requestNotificationPermissions() async {
    final status = await Permission.notification.request();

    if (status.isGranted) {
      // Permissions granted, you can send notifications
    } else if (status.isDenied) {
      // Permissions denied, you can inform the user about the importance of notifications
    } else if (status.isPermanentlyDenied) {
      // Permissions permanently denied, you can show a dialog or redirect the user to settings
    }
  }

  @override
  void initState() {
    setApiData();
    getIsSignIn();
    getUserData();
    getPriceData();
    getcontactdata();
    getlanguage();
    requestNotificationPermissions();

    super.initState();
  }

  getcontactdata() async {
    try {
      var request = await http.get(Uri.parse('$baseUrl/settings/contact-us'),
          headers: headers);
      if (request.statusCode == 200) {
        Map data = json.decode(request.body);
        contactPhone = data["contactPhone"];
        contactEmail = data["contactEmail"];
      }
    } catch (_) {}
  }

  getIsSignIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isSign = pref.getBool("isSign") ?? false;
  }

  getlanguage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    language = pref.getInt("language") ?? 0;
  }

  setApiData() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    try {
      var request = await http.get(Uri.parse('$baseUrl/get-request-form-data'),
          headers: headers);

      if (request.statusCode == 200) {
        Map<String, dynamic> data = json.decode(request.body);
        List city = data["cities"];
        List nat = data["natures"];
        List ty = data["types"];

        List<String> city2 = [];
        List<String> nat2 = [];
        List<String> ty2 = [];
        for (Map element in city) {
          city2.add(language == 0 ? element["name"] : element["nameEn"]);
          citiesAr.add(element["name"]);
          citiesEn.add(element["nameEn"]);
        }
        for (Map element in nat) {
          nat2.add(language == 0 ? element["name"] : element["nameEn"]);
        }
        for (Map element in ty) {
          ty2.add(language == 0 ? element["name"] : element["nameEn"]);
        }
        cities = city2;
        natures = nat2;
        types = ty2;

        getPriceData();
      } else {
        log("e.toString()");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const NoInternet()),
            (route) => false);
      }
    } catch (e) {
      log(e.toString());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NoInternet()),
          (route) => false);
    }
  }

  getPriceData() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    try {
      var request =
          await http.get(Uri.parse('$baseUrl/level-pricing'), headers: headers);
      if (request.statusCode == 200) {
        List data11 = json.decode(request.body)["buildings"];
        List data21 = json.decode(request.body)["villas"];
        floors = [];
        floorsNameList = [];
        for (int i = 0; i < data11.length; i++) {
          floors.add(Pricing(
              name: data11[i]["level"],
              buildingPrice: data11[i]["price"],
              villasPrice: i < 6 ? data21[i]["price"] : 0));

          floorsNameList.add(data11[i]["level"].toString());
        }
        floorsNameList.add("G+5");

        data2();
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const NoInternet()),
            (route) => false);
      }
    } catch (e) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NoInternet()),
          (route) => false);
    }
  }

  data2() async {
    var request2 = await http.get(Uri.parse('$baseUrl/'), headers: headers);
    try {
      if (request2.statusCode == 200) {
        Map<String, dynamic> data = json.decode(request2.body);

        List ser = data["services"];

        List<Services> ser2 = [];

        for (Map element in ser) {
          ser2.add(Services(
              name: language == 0 ? element["name"] : element["nameEn"],
              image: element["image"],
              description: language == 0
                  ? element["description"]
                  : element["descriptionEn"]));
        }

        services = ser2;

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MainPage(pageIndex: widget.mainPageIndex)),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const NoInternet()),
            (route) => false);
      }
    } catch (_) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NoInternet()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Image.asset(
        "assets/splash.gif",
        fit: BoxFit.fill,
        width: deviceWidth,
        height: deviceHeight,
      ),
    );
  }
}
