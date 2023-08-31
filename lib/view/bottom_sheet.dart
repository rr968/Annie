import 'package:build/controller/button.dart';
import 'package:build/main.dart';
import 'package:build/view/Language/language.dart';
import 'package:flutter/material.dart';

void bottomSheet(BuildContext context) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image2.png",
              height: 180,
              width: 180,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                translateText["text8"]![language],
                textAlign: TextAlign.center,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: longButton(translateText["OK"]![language]),
              ),
            ),
          ],
        ),
      );
    },
  );
}
