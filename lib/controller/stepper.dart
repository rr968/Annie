import 'package:build/Language/language.dart';
import 'package:build/main.dart';
import 'package:build/view/FirstSevice/first_service.dart';
import 'package:flutter/material.dart';

Widget stepper(int finshedStep) {
  int complete = finshedStep * 100 ~/ 7;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: language == 0 ? 20 : 13),
    child: Column(
      children: [
        Text(
          language == 0 ? "%$complete منجز" : "$complete% Completed",
          style: textStyle3(),
        ),
        Container(
          height: 5,
        ),
        Container(
          height: 30,
          width: deviceWidth * .7,
          decoration: BoxDecoration(
              color: Colors.green.shade700,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding:
                EdgeInsets.only(right: (deviceWidth * .7) * finshedStep / 7),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
            ),
          ),
        ),
        Container(
          height: 18,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: language == 0 ? 8 : 0, right: language == 0 ? 0 : 8),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: maincolor2, borderRadius: BorderRadius.circular(40)),
                child: Image.asset(
                  "assets/check.png",
                ),
              ),
            ),
            Text(
              translateText["step1"]![language],
              style: textStyle4(),
            )
          ],
        ),
        line(),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: language == 0 ? 8 : 0, right: language == 0 ? 0 : 8),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: maincolor2, borderRadius: BorderRadius.circular(40)),
                child: Image.asset("assets/check.png"),
              ),
            ),
            Text(
              translateText["step2"]![language],
              style: textStyle4(),
            )
          ],
        ),
        line(),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: language == 0 ? 8 : 0, right: language == 0 ? 0 : 8),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: maincolor2, borderRadius: BorderRadius.circular(40)),
                child: finshedStep > 2
                    ? Image.asset("assets/check.png")
                    : Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          "assets/offer2.png",
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
            Text(
              translateText["step3"]![language],
              style: textStyle4(),
            )
          ],
        ),
        line(),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: language == 0 ? 8 : 0, right: language == 0 ? 0 : 8),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: maincolor2, borderRadius: BorderRadius.circular(40)),
                child: finshedStep > 3
                    ? Image.asset("assets/check.png")
                    : Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          "assets/choice.png",
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
            Text(
              translateText["step4"]![language],
              style: textStyle4(),
            )
          ],
        ),
        line(),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: language == 0 ? 8 : 0, right: language == 0 ? 0 : 8),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: maincolor2, borderRadius: BorderRadius.circular(40)),
                child: finshedStep > 4
                    ? Image.asset("assets/check.png")
                    : Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          "assets/signature.png",
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
            Text(
              translateText["step5"]![language],
              style: textStyle4(),
            )
          ],
        ),
        line(),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: language == 0 ? 8 : 0, right: language == 0 ? 0 : 8),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: maincolor2, borderRadius: BorderRadius.circular(40)),
                child: finshedStep > 5
                    ? Image.asset("assets/check.png")
                    : Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          "assets/megaphone.png",
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
            Text(
              translateText["step6"]![language],
              style: textStyle4(),
            )
          ],
        ),
        line(),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: language == 0 ? 8 : 0, right: language == 0 ? 0 : 8),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: maincolor2, borderRadius: BorderRadius.circular(40)),
                child: finshedStep > 6
                    ? Image.asset("assets/check.png")
                    : Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          "assets/finish.png",
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
            Text(
              translateText["step7"]![language],
              style: textStyle4(),
            )
          ],
        ),
      ],
    ),
  );
}

Widget stepper2(int finshedStep) {
  print(finshedStep);
  int complete = finshedStep == 8 ? 100 : 66;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: language == 0 ? 20 : 13),
    child: Column(
      children: [
        Text(
          language == 0 ? "%$complete منجز" : "$complete% Completed",
          style: textStyle3(),
        ),
        Container(
          height: 5,
        ),
        Container(
          height: 30,
          width: deviceWidth * .7,
          decoration: BoxDecoration(
              color: Colors.green.shade700,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.only(
                right: finshedStep == 8
                    ? (deviceWidth * .7)
                    : (deviceWidth * .7) * .6),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
            ),
          ),
        ),
        Container(
          height: 18,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: language == 0 ? 8 : 0, right: language == 0 ? 0 : 8),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: maincolor2, borderRadius: BorderRadius.circular(40)),
                child: Image.asset(
                  "assets/check.png",
                ),
              ),
            ),
            Text(
              translateText["step1"]![language],
              style: textStyle4(),
            )
          ],
        ),
        line(),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: language == 0 ? 8 : 0, right: language == 0 ? 0 : 8),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: maincolor2, borderRadius: BorderRadius.circular(40)),
                child: Image.asset("assets/check.png"),
              ),
            ),
            Text(
              translateText["step2"]![language],
              style: textStyle4(),
            )
          ],
        ),
        line(),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: language == 0 ? 8 : 0, right: language == 0 ? 0 : 8),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: maincolor2, borderRadius: BorderRadius.circular(40)),
                child: finshedStep == 8
                    ? Image.asset("assets/check.png")
                    : Padding(
                        padding: const EdgeInsets.all(6),
                        child: Image.asset(
                          "assets/finish.png",
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
            Text(
              translateText["step31"]![language],
              style: textStyle4(),
            )
          ],
        ),
      ],
    ),
  );
}

Widget line() {
  return Padding(
    padding: EdgeInsets.only(right: 17, left: language == 0 ? 0 : 18),
    child: Align(
      alignment: language == 0 ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        height: 25,
        width: 2,
        color: Colors.grey,
      ),
    ),
  );
}
