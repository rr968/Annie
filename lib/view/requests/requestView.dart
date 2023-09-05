// ignore_for_file: use_build_context_synchronously, file_names, avoid_function_literals_in_foreach_calls

import 'dart:convert';

import 'package:build/controller/button.dart';
import 'package:build/controller/constant.dart';
import 'package:build/controller/erroralert.dart';
import 'package:build/controller/done.dart';
import 'package:build/main.dart';
import 'package:build/model/request_info.dart';
import 'package:build/view/FirstSevice/first_service.dart';
import 'package:build/view/Language/language.dart';
import 'package:build/view/mainpage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../controller/snackbar.dart';

class ReqestView extends StatefulWidget {
  final int id;

  const ReqestView({super.key, required this.id});

  @override
  State<ReqestView> createState() => _ReqestViewState();
}

class _ReqestViewState extends State<ReqestView> {
  List<String> filesPath = [];
  bool isLoading = true;
  late RequestInfo requestInfo;
  final items = types;
  int groupValue1 = 0;
  int groupValue2 = 0;
  int numOfFiles = 1;
  @override
  void initState() {
    getRequestView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: language == 0 ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(color: maincolor),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 315,
                        child: Stack(
                          children: [
                            Image.network(
                              services[requestInfo.serviceId - 1].image,
                              fit: BoxFit.fill,
                              height: 260,
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 184),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * .85,
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .85,
                                            ),
                                            Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    services[requestInfo
                                                                .serviceId -
                                                            1]
                                                        .name,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 25),
                                                    child: FittedBox(
                                                      child: Text(
                                                        services[requestInfo
                                                                    .serviceId -
                                                                1]
                                                            .description,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                          borderRadius:
                                              BorderRadius.circular(23),
                                        ),
                                        child: Center(
                                          child: Text(
                                            translateText["Save_money"]![
                                                language],
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
                                        borderRadius:
                                            BorderRadius.circular(100)),
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
                                requestInfo.serviceId == 1
                                    ? Column(
                                        children: [
                                          Align(
                                            alignment: language == 0
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                            child: Text(
                                              translateText["build_type"]![
                                                  language],
                                              style: normalTextStyle(),
                                            ),
                                          ),
                                          for (int i = 0;
                                              i < natures.length;
                                              i = i + 2)
                                            Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        buildRadioButton(i, 0),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Text(
                                                            natures[i],
                                                            style:
                                                                normalTextStyle(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  i + 1 < natures.length
                                                      ? Expanded(
                                                          child: Row(
                                                            children: [
                                                              buildRadioButton(
                                                                  i + 1, 0),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: EdgeInsets.all(
                                                                      language ==
                                                                              0
                                                                          ? 10
                                                                          : 2),
                                                                  child: Text(
                                                                    natures[
                                                                        i + 1],
                                                                    style:
                                                                        normalTextStyle(),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : Expanded(
                                                          child: Container(),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              translateText["text3"]![language],
                                              style: normalTextStyle(),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              for (int i = 0;
                                                  i < cities.length;
                                                  i = i + 2)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          buildRadioButton(
                                                              i, 1),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Text(
                                                              cities[i],
                                                              style:
                                                                  normalTextStyle(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    i + 1 < cities.length
                                                        ? Expanded(
                                                            child: Row(
                                                              children: [
                                                                buildRadioButton(
                                                                    i + 1, 1),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          10),
                                                                  child: Text(
                                                                    cities[
                                                                        i + 1],
                                                                    style:
                                                                        normalTextStyle(),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : Expanded(
                                                            child: Container(),
                                                          ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Container(),
                                Container(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          translateText["projectType"]![
                                              language],
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
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20, left: 20),
                                              child: Center(
                                                child: Text(
                                                  language == 0
                                                      ? requestInfo.requestType
                                                      : requestInfo
                                                          .requestTypeEn,
                                                  style: normalTextStyle(),
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
                                        translateText["numberoffloors"]![
                                            language],
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
                                                      color: maincolor,
                                                      width: 1.5),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20, left: 20),
                                                  child: Center(
                                                    child: Text(
                                                      requestInfo.floorsCount
                                                          .toString(),
                                                      style: normalTextStyle(),
                                                    ),
                                                  )),
                                            ),
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
                                              translateText["Uploadcharts"]![
                                                  language],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: maincolor,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          Text(
                                            translateText["text4"]![language],
                                            textAlign: TextAlign.start,
                                            style:
                                                const TextStyle(fontSize: 11),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 15,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        if (requestInfo.editable) {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles(
                                                      allowMultiple: true);
                                          if (result != null) {
                                            filesPath = [];
                                            for (var element in result.files) {
                                              if (element.path != null) {
                                                filesPath.add(element.path!);
                                              }
                                            }

                                            setState(() {
                                              numOfFiles = filesPath.length;
                                            });
                                          } else {
                                            // User canceled the picker
                                          }
                                        }
                                      },
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .35,
                                        child: Container(
                                          height: 75,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              color: const Color(0xffF2F2F2),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: requestInfo.files.isEmpty
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
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FittedBox(
                                                      child: Text(
                                                          "تم تحميل $numOfFiles من الملفات"),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 35,
                                ),
                                InkWell(
                                    onTap: () async {
                                      if (requestInfo.editable) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        updateData();
                                      }
                                    },
                                    child: isLoading
                                        ? loadingButton()
                                        : requestInfo.editable
                                            ? longButton(translateText["Edit"]![
                                                language])
                                            : greyLongButton(translateText[
                                                "Edit"]![language])),
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
      ),
    );
  }

  getRequestView() async {
    var headers2 = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${currentUser.token}'
    };
    try {
      var request = await http.get(
          Uri.parse('$baseUrl/view-request/${widget.id}'),
          headers: headers2);

      if (request.statusCode == 200) {
        Map element = json.decode(request.body);

        requestInfo = RequestInfo(
            requestId: element["requestId"],
            serviceId: element["serviceId"],
            status: element["status"],
            serviceName: element["serviceName"],
            serviceNameEn: element["serviceNameEn"],
            requestType: element["requestType"],
            requestTypeEn: element["requestTypeEn"],
            requestNature: element["requestNature"],
            requestNatureEn: element["requestNatureEn"],
            floorsCount: element["floorsCount"],
            cityId: element["cityId"],
            rejectionReason: element["rejectionReason"],
            editable: element["editable"],
            files: element["files"]);

        setState(() {
          if (language == 0) {
            groupValue1 =
                natures.indexOf(requestInfo.requestNature ?? "بناء جديد");
          } else {
            groupValue1 =
                natures.indexOf(requestInfo.requestNatureEn ?? "new building");
          }
          groupValue2 = ((requestInfo.cityId ?? 1) - 1);
          numOfFiles = requestInfo.files.length;
          isLoading = false;
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
            (route) => false);
        erroralert(context, "حدث خطأ يرجى إعادة المحاولة");
      }
    } catch (e) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
          (route) => false);
      erroralert(context, "حدث خطأ يرجى إعادة المحاولة");
    }
  }

  updateData() async {
    try {
      var headers2 = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${currentUser.token}'
      };
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/update-request'));
      request.fields.addAll({'requestId': requestInfo.requestId.toString()});
      filesPath.forEach((element) async {
        request.files
            .add(await http.MultipartFile.fromPath('files[]', element));
      });
      request.headers.addAll(headers2);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DonePage()),
            (route) => false);
      } else {
        setState(() {
          isLoading = false;
        });
        var data = json.decode(await response.stream.bytesToString());
        snackbar(context, data["message"]);
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      snackbar(context, translateText["checkInternet"]![language]);
    }
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
  Widget buildRadioButton(int index, int groupIndex) {
    final isSelected =
        groupIndex == 0 ? groupValue1 == index : groupValue2 == index;

    return InkWell(
      onTap: () {
        /* setState(() {
          groupIndex == 0 ? groupValue1 = index : groupValue2 = index;
        });*/
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isSelected ? maincolor : Colors.white,
          border: Border.all(
            color: isSelected ? maincolor : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: const Icon(
          Icons.done,
          color: Colors.white,
          size: 21,
        ),
      ),
    );
  }
}
