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
  ScrollController scrollController = ScrollController();
  double _scrollPercentage = 0;
  @override
  void initState() {
    scrollController.addListener(_calculateScrollPercentage);
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the ScrollController when done
    scrollController.dispose();
    super.dispose();
  }

  void _calculateScrollPercentage() {
    final maxScrollExtent = scrollController.position.maxScrollExtent;
    final currentScrollOffset = scrollController.offset;
    final newScrollPercentage =
        (currentScrollOffset / maxScrollExtent).clamp(0.0, 1.0);

    setState(() {
      _scrollPercentage = newScrollPercentage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
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
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          height: deviceHeight - 200,
                          width: 10,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 215, 215, 215),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                // top: _scrollPercentage * (deviceHeight - 300),
                                bottom: _scrollPercentage == 0
                                    ? deviceHeight - 240
                                    : (deviceHeight - 240) *
                                        (1 - _scrollPercentage)),
                            child: Container(
                              width: 10,
                              decoration: BoxDecoration(
                                  color: pinkcolor,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: deviceHeight - 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 234, 234, 234)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView(
                                controller: scrollController,
                                children: [
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
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: groupValue1
                                                  ? pinkcolor
                                                  : Colors.white,
                                              border: Border.all(
                                                color: groupValue1
                                                    ? pinkcolor
                                                    : Colors.grey,
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
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
                                                      backgroundColor:
                                                          Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                      ),
                                                      content: Provider.of<
                                                                          MyProvider>(
                                                                      context)
                                                                  .isLoadingChooseOffer ||
                                                              Provider.of<
                                                                  MyProvider>(
                                                                context,
                                                              ).isLoadingConfirmOffer
                                                          ? SizedBox(
                                                              height: 40,
                                                              width: 40,
                                                              child: FittedBox(
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  strokeWidth:
                                                                      7,
                                                                  color:
                                                                      maincolor,
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox(
                                                              height: 400,
                                                              width: double
                                                                  .infinity,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "إسم المقاول الذي اخترته هو : $companyName ( تم إظهاره في قائمة العروض)  يرجى الضغط على تأكيد الإختيار",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color:
                                                                            maincolor),
                                                                  ),
                                                                  Text(
                                                                    "ملاحظة: يمكنك العودة الى قائمة الأسعار",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color:
                                                                            maincolor),
                                                                  ),
                                                                  Container(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    "تذكر أن لديك ٣ محاولات لإظهار إسماء مقاولين قبل تأكيد إحداها",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color:
                                                                            maincolor),
                                                                  ),
                                                                  Container(
                                                                    height: 20,
                                                                  ),
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
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
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          40,
                                                                      // width: 90,
                                                                      decoration: BoxDecoration(
                                                                          gradient: const LinearGradient(
                                                                            begin:
                                                                                Alignment.topLeft,
                                                                            end:
                                                                                Alignment.bottomRight,
                                                                            colors: [
                                                                              Color(0xffAA277B),
                                                                              Color(0xff4C2963),
                                                                            ],
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          color: maincolor),
                                                                      child:
                                                                          const Padding(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 8),
                                                                        child: Center(
                                                                            child: Text(
                                                                          " تأكيد الاختيار ",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold),
                                                                        )),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: 10,
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
                                                                              builder: (context) => Offers(
                                                                                    requestId: widget.requestId,
                                                                                    serviceId: widget.selectedResponseId,
                                                                                  )));
                                                                    },
                                                                    child:
                                                                        const Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              8),
                                                                      child: Center(
                                                                          child: Text(
                                                                        "العودة إلى العروض",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black54,
                                                                            fontWeight: FontWeight.bold),
                                                                      )),
                                                                    ),
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
                                      : greyLongButton(
                                          translateText["next"]![language]),
                                  Container(
                                    height: 40,
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ))
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
