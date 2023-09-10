import 'package:build/view/splash.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../Language/language.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Image.asset(
              'assets/no_internet.gif',
              height: 200,
              fit: BoxFit.contain,
            ),
            Text(translateText["checkInternet"]![language],
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.black54, fontWeight: FontWeight.normal)),
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
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child: Text(
                  "إعادة المحاولة",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
