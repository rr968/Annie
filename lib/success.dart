import 'package:build/controller/button.dart';
import 'package:build/main.dart';
import 'package:build/view/Language/language.dart';
import 'package:build/view/splash.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

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
                  child: Text(translateText["sucess_pay"]![language],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: maincolor,
                          fontSize: 30)),
                ),
              ),
              Container(
                height: 15,
              ),
              Text(translateText["text7"]![language],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 18)),
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
