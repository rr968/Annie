import 'dart:convert';

import 'package:build/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';

import '../../controller/constant.dart';
import '../Language/language.dart';

class Conditions extends StatefulWidget {
  const Conditions({super.key});

  @override
  State<Conditions> createState() => _ConditionsState();
}

class _ConditionsState extends State<Conditions> {
  String text = "";
  bool isLoading = true;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    try {
      var request = await http.get(Uri.parse('$baseUrl/settings/terms'),
          headers: headers);
      if (request.statusCode == 200) {
        text = json.decode(request.body)["terms"];
        setState(() {
          isLoading = false;
        });
      } else {
        text = translateText["checkInternet"]![language];
        setState(() {
          isLoading = false;
        });
      }
    } catch (_) {
      text = translateText["checkInternet"]![language];
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Padding(
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 234, 234, 234)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: isLoading
                            ? Center(
                                child:
                                    CircularProgressIndicator(color: maincolor),
                              )
                            : Html(
                                style: {
                                  "html": Style(
                                    fontSize: FontSize(18.0),
                                    //  fontWeight: FontWeight.bold,
                                  ),
                                  "p": Style(
                                    fontSize: FontSize(18.0),
                                  ),
                                  "a": Style(
                                    fontSize: FontSize(18.0),
                                  ),
                                },
                                data: text,
                              ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
