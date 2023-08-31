// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:build/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../controller/button.dart';
import '../../controller/constant.dart';
import '../../controller/snackbar.dart';
import '../../success.dart';
import '../FirstSevice/first_service.dart';
import '../Language/language.dart';

class SecondService extends StatefulWidget {
  const SecondService({super.key});

  @override
  State<SecondService> createState() => _SecondServiceState();
}

class _SecondServiceState extends State<SecondService> {
  final TextEditingController _numberOfFloor = TextEditingController();

  final items = types;
  String dropDownValue = types[0];
  List<String> filesPath = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == 0 ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 315,
                child: Stack(
                  children: [
                    Image.network(
                      services[1].image,
                      fit: BoxFit.fill,
                      height: 260,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 184),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .85,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                  color: Colors.grey)
                            ],
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white.withOpacity(1),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      "assets/blure2.png",
                                      fit: BoxFit.fill,
                                      height: 90,
                                      width: MediaQuery.of(context).size.width *
                                          .85,
                                    ),
                                    Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            services[1].name,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25),
                                            child: FittedBox(
                                              child: Text(
                                                services[1].description,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(23),
                                ),
                                child: Center(
                                  child: Text(
                                    translateText["Save_money"]![language],
                                    style: const TextStyle(
                                        color: Color(0xff21E900),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 20),
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 43,
                            width: 43,
                            decoration: BoxDecoration(
                                color: const Color(0xffAA277B),
                                borderRadius: BorderRadius.circular(100)),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Image.asset(
                                "assets/arrowback.gif",
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 400,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          translateText["text5"]![language],
                          style: normalTextStyle(),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            translateText["text6"]![language],
                            style: normalTextStyle(),
                          ),
                        ),
                        Container(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Text(
                                  translateText["projectType"]![language],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: maincolor,
                                      fontSize: 20),
                                ),
                              ),
                              Container(
                                width: 20,
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: maincolor, width: 1.5),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, left: 20),
                                      child: Center(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            alignment: Alignment.center,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            value: dropDownValue,
                                            isExpanded: true,
                                            icon: Image.asset(
                                              "assets/arrow2.png",
                                              height: 13,
                                            ),
                                            items: items
                                                .map(buildMenueItems)
                                                .toList(),
                                            onChanged: (v) {
                                              setState(() {
                                                dropDownValue = v!;
                                              });
                                            },
                                          ),
                                        ),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                translateText["numberoffloors"]![language],
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: maincolor,
                                    fontSize: 20),
                              ),
                            ),
                            Container(
                              width: 20,
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        height: 55,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: maincolor, width: 1.5),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _numberOfFloor,
                                            cursorColor: maincolor,
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: const TextInputType
                                                    .numberWithOptions(
                                                signed: true, decimal: false),
                                            decoration: const InputDecoration(
                                                border: InputBorder.none),
                                          ),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      translateText["Floor"]![language],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: maincolor,
                                          fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: language == 0
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Text(
                                      translateText["Uploadcharts"]![language],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: maincolor,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Text(
                                    translateText["text4"]![language],
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(fontSize: 11),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 15,
                            ),
                            InkWell(
                              onTap: () async {
                                FilePickerResult? result = await FilePicker
                                    .platform
                                    .pickFiles(allowMultiple: true);
                                if (result != null) {
                                  filesPath = [];
                                  for (var element in result.files) {
                                    if (element.path != null) {
                                      filesPath.add(element.path!);
                                    }
                                  }

                                  setState(() {});
                                } else {
                                  // User canceled the picker
                                }
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .35,
                                child: Container(
                                  height: 75,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      color: const Color(0xffF2F2F2),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: filesPath.isEmpty
                                        ? Row(children: [
                                            const Expanded(
                                              child: FittedBox(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                        "Select a file or drag and drop here"),
                                                    Text(
                                                        "PDF, file size no more than 10MB"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 10,
                                            ),
                                            Image.asset(
                                                "assets/feather_upload-cloud.png")
                                          ])
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FittedBox(
                                              child: Text(
                                                  "تم تحميل ${filesPath.length} من الملفات"),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 25,
                        ),
                        Text(
                          language == 0
                              ? "سيتم دفع 500 درهم رسوم"
                              : "A fee of 500 dirhams will be paid.",
                          style: normalTextStyle(),
                        ),
                        Container(
                          height: 17,
                        ),
                        InkWell(
                            onTap: () async {
                              setState(() {
                                isLoading = true;
                              });

                              String requestType =
                                  (types.indexOf(dropDownValue) + 1).toString();
                              String floorsCount = _numberOfFloor.text;
                              Map<String, String> headers2 = {
                                'Accept': 'application/json',
                                'Content-Type': 'application/json',
                                'Authorization': 'Bearer ${currentUser.token}'
                              };

                              try {
                                var request = http.MultipartRequest('POST',
                                    Uri.parse('$baseUrl/find-constructor'));
                                request.fields.addAll({
                                  'requestType': requestType,
                                  'floorsCount': floorsCount
                                });
                                request.files.add(
                                    await http.MultipartFile.fromPath(
                                        'files[]', filesPath[0]));

                                request.headers.addAll(headers2);

                                http.StreamedResponse response =
                                    await request.send();
                                Map data = json.decode(
                                    await response.stream.bytesToString());
                                if (response.statusCode == 201) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SuccessPage()),
                                      (route) => false);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  snackbar(context, data["message"]);
                                }
                              } catch (_) {
                                setState(() {
                                  isLoading = false;
                                });
                                snackbar(context,
                                    translateText["checkInternet"]![language]);
                              }
                            },
                            child: isLoading
                                ? loadingButton()
                                : longButton(
                                    translateText["Askـservice"]![language])),
                        Container(
                          height: 40,
                        )
                      ],
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

  DropdownMenuItem<String> buildMenueItems(String item) => DropdownMenuItem(
      value: item,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item,
            style: normalTextStyle(),
          ),
        ],
      ));
}
