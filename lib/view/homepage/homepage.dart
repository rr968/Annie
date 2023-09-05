import 'package:build/controller/constant.dart';
import 'package:build/controller/helper.dart';
import 'package:build/main.dart';
import 'package:build/view/Auth/login.dart';
import 'package:build/view/FirstSevice/first_service.dart';
import 'package:build/view/SecondService/secondservice.dart';
import 'package:build/view/splash.dart';
import 'package:flutter/material.dart';

import '../../controller/pageroute.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Image.asset(
                "assets/Isolation_Mode.png",
                color: Colors.black54,
                fit: BoxFit.fill,
                height: 150,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Container(
                  height: 55,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            child: InkWell(
                              onTap: () {
                                setlanguage(language == 0 ? 1 : 0);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Splash()),
                                    (route) => false);
                              },
                              child: Image.asset(
                                language == 0
                                    ? "assets/ar.png"
                                    : "assets/en.png",
                                height: 33,
                              ),
                            ),
                          ),
                          Image.asset(
                            "assets/logo-2.png",
                            height: 65,
                          ),
                          InkWell(
                            onTap: () {
                              if (!isSign) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()));
                              }
                            },
                            child: Text(
                              isSign ? "             " : "تسجيل الدخول",
                              style: TextStyle(
                                  color: maincolor,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                          height: 250, child: Image.asset("assets/cur.gif")),
                      box(services[0].name, services[0].description,
                          services[0].image, () {
                        Navigator.of(context).push(createRoute(
                            isSign ? const FirstService() : const Login()));
                      }),
                      box(services[1].name, services[1].description,
                          services[1].image, () {
                        Navigator.of(context).push(createRoute(
                            isSign ? const SecondService() : const Login()));
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  box(String text1, String text2, String img, Function()? ontap) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 10, horizontal: MediaQuery.of(context).size.width * .1),
      child: InkWell(
        onTap: ontap,
        child: Stack(
          children: [
            Container(
                height: 160,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          spreadRadius: 0, blurRadius: 10, color: Colors.grey)
                    ],
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(
                          img,
                        ),
                        fit: BoxFit.fill)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 72),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          text1,
                          style: TextStyle(
                              color: maincolor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: SizedBox(
                              height: 40,
                              child: Text(
                                text2,
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(color: maincolor, fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: const Color(0xffAA277B),
                    borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(
                    "assets/arrowforward.gif",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
