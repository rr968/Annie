// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:build/controller/button.dart';
import 'package:build/controller/constant.dart';
import 'package:build/controller/success.dart';
import 'package:build/main.dart';
import 'package:build/view/Language/language.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../controller/snackbar.dart';

class Contract extends StatefulWidget {
  final String title1;
  final String title2;
  final String content;
  final int requestId;
  final int selectedResponseId;
  const Contract(
      {super.key,
      required this.title1,
      required this.title2,
      required this.content,
      required this.requestId,
      required this.selectedResponseId});

  @override
  State<Contract> createState() => _ContractState();
}

class _ContractState extends State<Contract> {
  bool groupValue1 = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 70,
                  bottom: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text("الشروط والأحكام",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: maincolor,
                                fontSize: 23)),
                        Text(
                          "Terms&Conditions",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: pinkcolor,
                              fontSize: 23),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 35,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Directionality(
              textDirection:
                  language == 0 ? TextDirection.rtl : TextDirection.ltr,
              child: Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 234, 234, 234)),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Text(widget.content),
                      Container(
                        height: 20,
                      ),
                      FittedBox(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  groupValue1 = !groupValue1;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: groupValue1 ? pinkcolor : Colors.white,
                                  border: Border.all(
                                    color:
                                        groupValue1 ? pinkcolor : Colors.grey,
                                    width: groupValue1 ? 2 : 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 21,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Text(
                                    "لقد قرأت العقد وجميع البنود وأوافق عليها",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: maincolor,
                                    ),
                                  ),
                                  Text(
                                    "I have read and agree to the contract and all terms",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: maincolor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 30,
                      ),
                      groupValue1
                          ? InkWell(
                              onTap: () {
                                selectOffer();
                              },
                              child: isLoading
                                  ? loadingButton()
                                  : longButton(
                                      translateText["next"]![language]))
                          : greyLongButton(translateText["next"]![language]),
                      Container(
                        height: 40,
                      )
                    ])),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  selectOffer() async {
    setState(() {
      isLoading = true;
    });

    Map<String, String> headers2 = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${currentUser.token}'
    };

    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/select-request-offer'));
      request.fields.addAll({
        'requestId': widget.requestId.toString(),
        'selectedResponseId': widget.selectedResponseId.toString(),
      });

      request.headers.addAll(headers2);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SuccessPage(
                    text1: translateText["sucess_selected"]![language],
                    text2: translateText["text12"]![language])),
            (route) => false);
      } else {
        var data = json.decode(await response.stream.bytesToString());
        setState(() {
          isLoading = false;
        });
        snackbar(context, data["message"]);
      }
    } catch (_) {
      setState(() {
        isLoading = false;
      });
      snackbar(context, translateText["checkInternet"]![language]);
    }
  }
}
