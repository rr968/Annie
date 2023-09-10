import 'package:build/controller/button.dart';
import 'package:build/main.dart';
import 'package:build/Language/language.dart';
import 'package:build/view/splash.dart';
import 'package:flutter/material.dart';

class DonePage extends StatefulWidget {
  const DonePage({super.key});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == 0 ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Image.asset(
                'assets/success.gif',
                height: 200,
                fit: BoxFit.contain,
              ),
              Text(translateText["thank"]![language],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: maincolor,
                      fontSize: 30)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: FittedBox(
                  child: Text(translateText["sucess_edit"]![language],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: maincolor,
                          fontSize: 30)),
                ),
              ),
              Container(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Splash()),
                      (route) => false);
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: longButton(
                      translateText["go_home"]![language],
                    )),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
