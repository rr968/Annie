import 'package:build/controller/button.dart';
import 'package:build/main.dart';
import 'package:build/Language/language.dart';
import 'package:build/view/offers/contract.dart';
import 'package:flutter/material.dart';

void bottomSheet(BuildContext context, int serviceid, int requestId,
    int selectedResponseId, String companyname, String period, String price) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: language == 0 ? TextDirection.rtl : TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(),
            ),
            Image.asset(
              "assets/image2.png",
              height: 180,
              width: 180,
            ),
            Expanded(
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    language == 0
                        ? "بما أنك اخترت عرض المقاول # $companyname بتكلفة $price درهم مدة التنفيذ $period شهر. "
                        : "Since you chose to offer the contractor # $companyname at a cost of $price AED and an implementation period of $period months.",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    translateText["text8"]![language],
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Contract(
                              title1: "عقد وساطة-مراجعة مخططات",
                              title2: "Mediation Contract- Review of Drawings",
                              content: serviceid == 1
                                  ? translateText["contract1"]![language]
                                  : translateText["contract2"]![language],
                              requestId: requestId,
                              selectedResponseId: selectedResponseId,
                            )));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: longButton(translateText["OK"]![language]),
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      );
    },
  );
}
