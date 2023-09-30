// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:build/controller/constant.dart';
import 'package:build/controller/erroralert.dart';
import 'package:build/controller/stepper.dart';
import 'package:build/main.dart';
import 'package:build/model/request.dart';
import 'package:build/view/FirstSevice/first_service.dart';
import 'package:build/Language/language.dart';
import 'package:build/view/mainpage.dart';
import 'package:build/view/requests/requestView.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  bool isLoading = true;
  List<Request> requestList = [];

  @override
  void initState() {
    getMyRequest();
    super.initState();
  }

  getMyRequest() async {
    var headers2 = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${currentUser.token}'
    };
    try {
      var request =
          await http.get(Uri.parse('$baseUrl/my-requests'), headers: headers2);

      if (request.statusCode == 200) {
        List data = json.decode(request.body);

        for (var element in data) {
          requestList.add(Request(
            id: element["id"],
            serviceId: element["serviceId"],
            serviceName: element["serviceName"],
            serviceNameEn: element["serviceNameEn"],
            status: element["status"],
            statusMsg: element["statusMsg"],
            statusMsgEn: element["statusMsgEn"],
            currentStep: element["currentStep"],
            selectedCompany: element["selectedCompany"],
            selectedOfferPrice: element["selectedOfferPrice"].toString(),
          ));
        }
        setState(() {
          isLoading = false;
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MainPage(pageIndex: 0)),
            (route) => false);
        erroralert(context, "حدث خطأ يرجى إعادة المحاولة");
      }
    } catch (e) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainPage(pageIndex: 0)),
          (route) => false);
      erroralert(context, "حدث خطأ يرجى إعادة المحاولة");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        body: Directionality(
          textDirection: language == 0 ? TextDirection.rtl : TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translateText["Services2"]![language],
                        style: textStyle2(),
                      ), /*
                      Icon(
                        language == 0
                            ? Icons.arrow_back_ios_new
                            : Icons.arrow_forward_ios,
                        size: 35,
                      )*/
                    ],
                  ),
                ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: maincolor),
                      )
                    : requestList.isEmpty
                        ? const Text("لا يوجد خدمات بعد")
                        : Expanded(
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                for (int i = 0; i < requestList.length; i++)
                                  noteBox(
                                      language == 0
                                          ? requestList[i].serviceName
                                          : requestList[i].serviceNameEn,
                                      requestList[i].id,
                                      language == 0
                                          ? requestList[i].statusMsg
                                          : requestList[i].statusMsgEn,
                                      requestList[i].status,
                                      requestList[i].currentStep - 1,
                                      requestList[i].serviceId,
                                      requestList[i].selectedCompany ?? ""),
                              ],
                            ),
                          ),
                Container(
                  height: 70,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noteBox(String title, int id, String status, int statusId,
      int finishedStep, int seviceId, String constName) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReqestView(
                      id: id,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: maincolor),
                    color: maincolor2.withOpacity(.4),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Align(
                                  alignment: language == 0
                                      ? Alignment.bottomLeft
                                      : Alignment.bottomRight,
                                  child: FittedBox(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: statusId != 2
                                              ? maincolor2
                                              : const Color.fromARGB(
                                                  255, 237, 86, 75),
                                          boxShadow: const [
                                            BoxShadow(
                                                offset: Offset(1, 4),
                                                spreadRadius: 0,
                                                blurRadius: 5,
                                                color: Colors.black45)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                translateText["status"]![
                                                        language] +
                                                    status,
                                                style: const TextStyle(
                                                    color:
                                                        //statusId != 2 ? const Color(0xffFC9AD9)
                                                        Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              statusId >= 5 &&
                                                      constName.isNotEmpty
                                                  ? Text(
                                                      translateText[
                                                                  "contName"]![
                                                              language] +
                                                          constName,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : Container(),
                                              statusId == 2
                                                  ? Text(
                                                      translateText[
                                                              "pressToEdit"]![
                                                          language],
                                                      style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color:
                                                              //statusId != 2 ? const Color(0xffFC9AD9)
                                                              Colors.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            Container(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 2,
                        // width: 2,
                        color: Colors.grey,
                      ),
                      Container(
                        height: 20,
                      ),
                      seviceId == 1
                          ? stepper(finishedStep)
                          : stepper2(finishedStep)
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment:
                  language == 0 ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                      color: maincolor2,
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(1, 4),
                            spreadRadius: 0,
                            blurRadius: 5,
                            color: Colors.black45)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      translateText["orderNum"]![language] + id.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
