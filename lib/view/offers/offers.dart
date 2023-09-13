// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:build/controller/bottom_sheet.dart';
import 'package:build/controller/button.dart';
import 'package:build/controller/constant.dart';
import 'package:build/controller/erroralert.dart';
import 'package:build/main.dart';
import 'package:build/model/offer.dart';
import 'package:build/view/FirstSevice/first_service.dart';
import 'package:build/Language/language.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Offers extends StatefulWidget {
  final int requestId;
  final int serviceId;
  const Offers({super.key, required this.requestId, required this.serviceId});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  bool isLoading = true;
  List<Offer> offers = [];
  int currentChoosse = -1;

  @override
  void initState() {
    getMyOffers();
    super.initState();
  }

  getMyOffers() async {
    var headers2 = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${currentUser.token}'
    };
    try {
      var request = await http.get(
          Uri.parse('$baseUrl/request-responses/${widget.requestId}'),
          headers: headers2);

      if (request.statusCode == 200) {
        List data = json.decode(request.body);

        for (var element in data) {
          offers.add(Offer(
              responseId: element["responseId"],
              requestId: element["requestId"],
              companyId: element["companyId"],
              price: element["price"],
              duration: element["duration"]));
        }
        setState(() {
          isLoading = false;
        });
      } else {
        Navigator.pop(context);
        erroralert(context, "حدث خطأ يرجى إعادة المحاولة");
      }
    } catch (e) {
      Navigator.pop(context);

      erroralert(context, "حدث خطأ يرجى إعادة المحاولة");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          translateText["appropriate"]![language],
                          style: textStyle2(),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        translateText["explain_text"]![language],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: maincolor,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: maincolor,
                      ),
                    )
                  : Expanded(
                      child: Column(
                        children: [
                          Directionality(
                            textDirection: language == 0
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            child: Expanded(
                                child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                for (int i = 0; i < offers.length; i++)
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        currentChoosse = i;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 15,
                                          top: 10,
                                          right: 10,
                                          left: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: currentChoosse == i
                                              ? const Color.fromARGB(
                                                  255, 136, 233, 139)
                                              : Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 2,
                                                blurRadius: 8,
                                                color: Colors.grey)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    border: Border.all()),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color:
                                                            currentChoosse == i
                                                                ? Colors.green
                                                                : Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .04),
                                              child: Text(
                                                translateText["text11"]![
                                                        language] +
                                                    offers[i]
                                                        .companyId
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: maincolor),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .25,
                                                  height: 53,
                                                  child: Center(
                                                      child: Text(
                                                    translateText[
                                                            "Offer_Price"]![
                                                        language],
                                                    style: TextStyle(
                                                        color: maincolor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .25,
                                                  height: 53,
                                                  child: Center(
                                                      child: Text(
                                                    translateText["period"]![
                                                        language],
                                                    style: TextStyle(
                                                        color: maincolor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .25,
                                                  height: 53,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .25,
                                                  height: 53,
                                                  decoration: BoxDecoration(
                                                      color: pinkcolor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                      child: Text(
                                                    "${offers[i].price} ${translateText["AED"]![language]}",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .25,
                                                  height: 53,
                                                  decoration: BoxDecoration(
                                                      color: pinkcolor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                      child: Text(
                                                    language == 0
                                                        ? '${offers[i].duration} يوم'
                                                        : '${offers[i].duration} day',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .27,
                                                  height: 53,
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                            spreadRadius: 2,
                                                            blurRadius: 8,
                                                            color: Colors.grey)
                                                      ],
                                                      color: greencolor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FittedBox(
                                                      child: Text(
                                                        translateText[
                                                                "Choose_offer"]![
                                                            language],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  )),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 20,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                Column(
                                  children: [
                                    Text(
                                      translateText["text9"]![language],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      translateText["text10"]![language],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: pinkcolor,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                          ),
                          currentChoosse != -1
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 25),
                                  child: InkWell(
                                      onTap: () {
                                        bottomSheet(
                                            context,
                                            widget.serviceId,
                                            offers[currentChoosse].requestId,
                                            offers[currentChoosse].responseId);
                                      },
                                      child: longButton("موافق")),
                                )
                              : Container()
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
