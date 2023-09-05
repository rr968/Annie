// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:build/controller/constant.dart';
import 'package:build/controller/erroralert.dart';
import 'package:build/main.dart';
import 'package:build/model/offer.dart';
import 'package:build/view/FirstSevice/first_service.dart';
import 'package:build/view/Language/language.dart';
import 'package:build/controller/bottom_sheet.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Offers extends StatefulWidget {
  final int requestId;
  const Offers({super.key, required this.requestId});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  bool isLoading = true;
  List<Offer> offers = [];

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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 55),
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
              Container(
                height: 20,
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
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .04),
                                        child: Text(
                                          translateText["text11"]![language] +
                                              offers[i].companyId.toString(),
                                          style: TextStyle(
                                              fontSize: 17, color: maincolor),
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
                                              translateText["Offer_Price"]![
                                                  language],
                                              style: TextStyle(
                                                  color: maincolor,
                                                  fontWeight: FontWeight.bold),
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
                                                  fontWeight: FontWeight.bold),
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
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                                child: Text(
                                              offers[i].price.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
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
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                                child: Text(
                                              language == 0
                                                  ? '${offers[i].duration} يوم'
                                                  : '${offers[i].duration} day',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              bottomSheet(
                                                  context,
                                                  1,
                                                  offers[i].requestId,
                                                  offers[i].responseId);
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .25,
                                              height: 53,
                                              decoration: BoxDecoration(
                                                  color: maincolor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FittedBox(
                                                  child: Text(
                                                    translateText[
                                                            "Choose_offer"]![
                                                        language],
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 20,
                                      )
                                    ],
                                  )
                              ],
                            )),
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
                          Container(
                            height: 10,
                          )
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
