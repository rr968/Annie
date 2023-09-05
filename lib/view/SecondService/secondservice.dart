// ignore_for_file: use_build_context_synchronously, avoid_function_literals_in_foreach_calls

import 'package:build/controller/no_imternet.dart';
import 'package:build/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_fatoorah/my_fatoorah.dart';

import '../../controller/button.dart';
import '../../controller/constant.dart';
import '../../controller/snackbar.dart';
import '../../controller/success.dart';
import '../FirstSevice/first_service.dart';
import '../Language/language.dart';

class SecondService extends StatefulWidget {
  const SecondService({super.key});

  @override
  State<SecondService> createState() => _SecondServiceState();
}

class _SecondServiceState extends State<SecondService> {
  final TextEditingController _numberOfFloor = TextEditingController();
  int currentPrice = 500;
  final items = types;
  String dropDownValue = types[0];
  List<String> filesPath = [];

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
                              ? "سيتم دفع ${currentPrice} درهم رسوم"
                              : "A fee of $currentPrice dirhams will be paid.",
                          style: normalTextStyle(),
                        ),
                        Container(
                          height: 17,
                        ),
                        InkWell(
                            onTap: () async {
                              String requestType =
                                  (types.indexOf(dropDownValue) + 1).toString();
                              int floorsCount = 2;
                              Map<String, String> headers2 = {
                                'Accept': 'application/json',
                                'Content-Type': 'application/json',
                                'Authorization': 'Bearer ${currentUser.token}'
                              };
                              bool isInteger = false;

                              try {
                                floorsCount =
                                    int.parse(_numberOfFloor.text.trim());
                                isInteger = true;
                              } catch (e) {
                                isInteger = false;
                              }

                              if (filesPath.isEmpty) {
                                snackbar(
                                    context, "يجب رفع المخططات الخاصة بمشروعك");
                              } else if (!isInteger) {
                                snackbar(context,
                                    "يجب إدخال عدد الطوابق بالشكل الصحيح");
                              } else {
                                var response = await MyFatoorah.startPayment(
                                  afterPaymentBehaviour: AfterPaymentBehaviour
                                      .AfterCallbackExecution,
                                  context: context,
                                  request: MyfatoorahRequest.test(
                                    currencyIso: Country.UAE,
                                    successUrl:
                                        'https://rosa.ae/payment/myfatoorah_api/success',
                                    errorUrl:
                                        'https://rosa.ae/payment/myfatoorah_api/failed',
                                    invoiceAmount: 100,
                                    language: language == 0
                                        ? ApiLanguage.Arabic
                                        : ApiLanguage.English,
                                    token: //fatoorahKey!,
                                        "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
                                  ),
                                );
                                if (response.isSuccess) {
                                  try {
                                    var request = http.MultipartRequest(
                                        'POST',
                                        Uri.parse(
                                            '$baseUrl/review-construction-plans'));
                                    request.fields.addAll({
                                      'requestType': requestType,
                                      'floorsCount': floorsCount.toString()
                                    });
                                    filesPath.forEach((element) async {
                                      request.files.add(
                                          await http.MultipartFile.fromPath(
                                              'files[]', element));
                                    });

                                    request.headers.addAll(headers2);

                                    http.StreamedResponse response =
                                        await request.send();

                                    if (response.statusCode == 201) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SuccessPage(
                                                  text1: translateText[
                                                      "sucess_pay"]![language],
                                                  text2: translateText[
                                                      "text7"]![language])),
                                          (route) => false);
                                    } else {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NoInternet()),
                                          (route) => false);
                                    }
                                  } catch (_) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NoInternet()),
                                        (route) => false);
                                  }
                                }
                              }
                            },
                            child: longButton(
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
