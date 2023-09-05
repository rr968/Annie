// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:build/model/services.dart';
import 'package:build/view/mainpage.dart';
import 'package:build/controller/no_imternet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/constant.dart';
import '../controller/helper.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int seconds = 100;
  @override
  void initState() {
    setApiData();
    getIsSignIn();
    getUserData();

    getlanguage();

    super.initState();
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

        data2();
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
            MaterialPageRoute(builder: (context) => const MainPage()),
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
