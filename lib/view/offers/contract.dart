// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:build/controller/button.dart';
import 'package:build/controller/confirm_offer.dart';
import 'package:build/controller/constant.dart';
import 'package:build/controller/no_imternet.dart';
import 'package:build/controller/provider.dart';
import 'package:build/main.dart';
import 'package:build/Language/language.dart';
import 'package:build/view/offers/offers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
  String companyName = "company";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.title1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: maincolor,
                                  fontSize: 16)),
                          Text(
                            widget.title2,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: pinkcolor,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 30,
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
                                    color:
                                        groupValue1 ? pinkcolor : Colors.white,
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
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return WillPopScope(
                                        onWillPop: () async {
                                          return false;
                                        },
                                        child: Directionality(
                                          textDirection: language == 0
                                              ? TextDirection.rtl
                                              : TextDirection.ltr,
                                          child: AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            content: Provider.of<MyProvider>(
                                                            context)
                                                        .isLoadingChooseOffer ||
                                                    Provider.of<MyProvider>(
                                                      context,
                                                    ).isLoadingConfirmOffer
                                                ? SizedBox(
                                                    height: 40,
                                                    width: 40,
                                                    child: FittedBox(
                                                      child:
                                                          CircularProgressIndicator(
                                                        strokeWidth: 7,
                                                        color: maincolor,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: 300,
                                                    width: double.infinity,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "هل انت متاكد من إختيار المقاول $companyName",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: maincolor),
                                                        ),
                                                        Text(
                                                          "يمكنك التاكيد لاحقا بعد إعادة النظر في المقاول",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: maincolor),
                                                        ),
                                                        Text(
                                                          "تذكر أن لديك ٣ محاولات لإظهار إسماء مقاولين قبل تأكيد إحداها",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: maincolor),
                                                        ),
                                                        Container(
                                                          height: 25,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                Provider.of<MyProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .setisLoadingConfirmOffer(
                                                                        true);
                                                                confirmOffer(
                                                                    widget
                                                                        .requestId,
                                                                    widget
                                                                        .selectedResponseId,
                                                                    context);
                                                              },
                                                              child: Container(
                                                                height: 40,
                                                                // width: 90,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color:
                                                                        maincolor),
                                                                child:
                                                                    const Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              8),
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    " تأكيد الاختيار ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                Navigator.pop(
                                                                    context);
                                                                Navigator.pop(
                                                                    context);
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            Offers(
                                                                              requestId: widget.requestId,
                                                                              serviceId: widget.selectedResponseId,
                                                                            )));
                                                              },
                                                              child: Container(
                                                                height: 40,
                                                                //   width: 90,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        gradient:
                                                                            const LinearGradient(
                                                                          begin:
                                                                              Alignment.topLeft,
                                                                          end: Alignment
                                                                              .bottomRight,
                                                                          colors: [
                                                                            Color(0xffAA277B),
                                                                            Color(0xff4C2963),
                                                                          ],
                                                                        ),
                                                                        color:
                                                                            maincolor),
                                                                child:
                                                                    const Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              8),
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    "العودة إلى العروض",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: longButton(
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
      ),
    );
  }

  selectOffer() async {
    Provider.of<MyProvider>(context, listen: false)
        .setisLoadingChooseOffer(true);
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
        var data = json.decode(await response.stream.bytesToString());
        log(data.toString());
        companyName = data["company"];

        Provider.of<MyProvider>(context, listen: false)
            .setisLoadingChooseOffer(false);
        /* Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => SuccessPage(
                    text1: translateText["sucess_selected"]![language],
                    text2: translateText["text12"]![language])),
            (route) => false);*/
      } else {
        Provider.of<MyProvider>(context, listen: false)
            .setisLoadingChooseOffer(false);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const NoInternet()),
            (route) => false);
      }
    } catch (_) {
      Provider.of<MyProvider>(context, listen: false)
          .setisLoadingChooseOffer(false);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NoInternet()),
          (route) => false);
    }
  }
}
