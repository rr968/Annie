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

class Contract2 extends StatefulWidget {
  const Contract2({
    super.key,
  });

  @override
  State<Contract2> createState() => _Contract2State();
}

class _Contract2State extends State<Contract2> {
  bool groupValue1 = false;
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
                          Text("عقد وساطة-مراجعة المخططات",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: maincolor,
                                  fontSize: 16)),
                          Text(
                            "Mediation contract",
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
                          textDirection: TextDirection.ltr,
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
                                  Text(translateText["contract2"]![language]),
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
                                            Provider.of<MyProvider>(context,
                                                    listen: false)
                                                .setContract2Accepted(true);
                                            Navigator.pop(context);
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
}
