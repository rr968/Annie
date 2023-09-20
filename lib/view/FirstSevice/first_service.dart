// ignore_for_file: use_build_context_synchronously, avoid_function_literals_in_foreach_calls

import 'dart:developer';

import 'package:build/controller/button.dart';
import 'package:build/controller/cachServicesInput.dart';
import 'package:build/controller/constant.dart';
import 'package:build/controller/erroralert.dart';
import 'package:build/controller/no_imternet.dart';
import 'package:build/main.dart';
import 'package:build/controller/success.dart';
import 'package:build/view/Auth/login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../controller/snackbar.dart';
import '../../Language/language.dart';

class FirstService extends StatefulWidget {
  const FirstService({super.key});

  @override
  State<FirstService> createState() => _FirstServiceState();
}

class _FirstServiceState extends State<FirstService> {
  final items = types;
  String dropDownValue = types[0];
  String dropDownFloorValue = floors[0].name;
  int groupValue1 = 0;
  int groupValue2 = 0;
  List<String> filesPath = [];
  int price = 500;
  bool isLoading = true;
  @override
  void initState() {
    getFisrtServiceBuildTypeIndex().then((buildtype) {
      log("buildtype $buildtype");
      if (buildtype != -1) {
        groupValue1 = buildtype;
      }
      getFisrtServiceLocationIndex().then((location) {
        log("location $location");
        if (location != -1) {
          groupValue2 = location;
        }
        getFisrtServiceNatureIndex().then((nature) {
          log("nature $nature");
          if (nature != -1) {
            dropDownValue = types[nature];
          }
          getFisrtServiceFloorNumber().then((floorNumber) {
            log("floorNumber $floorNumber");
            if (floorNumber != -1 && !(floorNumber >= 10)) {
              dropDownFloorValue = floors[floorNumber].name;
            }

            getFisrtServiceFiles().then((files) {
              log(files.toString());
              filesPath = files;
              setState(() {
                isLoading = false;
              });
            });
          });
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: language == 0 ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 330,
                      child: Stack(
                        children: [
                          Image.network(
                            services[0].image,
                            fit: BoxFit.fill,
                            height: 260,
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 150),
                              child: Container(
                                height: 150,
                                width: deviceWidth * .85,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: 0,
                                        color: Colors.grey)
                                  ],
                                  borderRadius: BorderRadius.circular(23),
                                  color: Colors.white.withOpacity(1),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            "assets/blure.png",
                                            fit: BoxFit.fill,
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
                                                  services[0].name,
                                                  style: TextStyle(
                                                      color: maincolor,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    services[0].description,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: maincolor,
                                                        fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 42,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(23),
                                      ),
                                      child: Center(
                                        child: Text(
                                          translateText["SaveEffort"]![
                                              language],
                                          style: TextStyle(
                                              color: greencolor,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 40,
                                width: 120,
                              ),
                              /*   Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: pinkcolor,
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
                                      translateText["save"]![language],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                           */
                              Padding(
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
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height - 330,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                translateText["text1"]![language],
                                style: normalTextStyle(),
                              ),
                              Text(
                                translateText["text2"]![language],
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: maincolor,
                                    fontSize: 16.5),
                              ),
                              for (int i = 0; i < natures.length; i = i + 2)
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            buildRadioButton(i, 0),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                natures[i],
                                                style: normalTextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      i + 1 < natures.length
                                          ? Expanded(
                                              child: Row(
                                                children: [
                                                  buildRadioButton(i + 1, 0),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          language == 0
                                                              ? 10
                                                              : 2),
                                                      child: Text(
                                                        natures[i + 1],
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
                                  for (int i = 0; i < cities.length; i = i + 2)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              buildRadioButton(i, 1),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  cities[i],
                                                  style: normalTextStyle(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        i + 1 < cities.length
                                            ? Expanded(
                                                child: Row(
                                                  children: [
                                                    buildRadioButton(i + 1, 1),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Text(
                                                        cities[i + 1],
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
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 20),
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
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20, left: 20),
                                            child: Center(
                                              child:
                                                  DropdownButtonHideUnderline(
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
                                                    int index =
                                                        floorsNameList.indexOf(
                                                            dropDownFloorValue);
                                                    int indextype = items
                                                        .indexOf(dropDownValue);
                                                    if (indextype == 0 &&
                                                        index > 5) {
                                                      dropDownFloorValue =
                                                          floorsNameList[5];
                                                    }
                                                    setFisrtServiceNatureIndex(
                                                        (types.indexOf(v!)));
                                                    setState(() {
                                                      dropDownValue = v;
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
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                alignment: Alignment.center,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                value: dropDownFloorValue,
                                                isExpanded: true,
                                                icon: Image.asset(
                                                  "assets/arrow2.png",
                                                  height: 13,
                                                ),
                                                items: floorsNameList
                                                    .map(buildMenueItems)
                                                    .toList(),
                                                onChanged: (v) {
                                                  setFisrtServiceFloorNumber(
                                                      ((floorsNameList
                                                          .indexOf(v!))));

                                                  setState(() {
                                                    dropDownFloorValue = v;
                                                  });
                                                },
                                              ),
                                            ),
                                          )),
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
                                      FilePickerResult? result =
                                          await FilePicker.platform
                                              .pickFiles(allowMultiple: true);
                                      if (result != null) {
                                        //filesPath = [];
                                        for (var element in result.files) {
                                          if (element.path != null) {
                                            filesPath.add(element.path!);
                                          }
                                        }
                                        setFisrtServiceFiles(filesPath);
                                        setState(() {});
                                      } else {
                                        // User canceled the picker
                                      }
                                    },
                                    child: SizedBox(
                                      width: deviceWidth * .35,
                                      child: Container(
                                        height: 75,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            color: const Color(0xffF2F2F2),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: filesPath.isEmpty
                                              ? Row(children: [
                                                  Image.asset(
                                                    "assets/add-post.png",
                                                    height: 27,
                                                  ),
                                                  Container(
                                                    width: 5,
                                                  ),
                                                  const Expanded(
                                                    child: FittedBox(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "إضغط هنا لرفع الملفات",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ])
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: FittedBox(
                                                    child: Text(
                                                      "تم تحميل ${filesPath.length} من الملفات \nإضغط لتحميل المزيد",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
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
                                    ? "سيتم دفع $price درهم رسوم"
                                    : "A fee of $price dirhams will be paid.",
                                style: normalTextStyle(),
                              ),
                              Container(
                                height: 17,
                              ),
                              InkWell(
                                  onTap: () async {
                                    if (isSign) {
                                      if (dropDownFloorValue ==
                                          floorsNameList[10]) {
                                        contactAlert(context);
                                      } else {
                                        String cityId =
                                            (groupValue2 + 1).toString();
                                        String requestNature =
                                            (groupValue1 + 1).toString();
                                        String requestType =
                                            (types.indexOf(dropDownValue) + 1)
                                                .toString();

                                        Map<String, String> headers2 = {
                                          'Accept': 'application/json',
                                          'Content-Type': 'application/json',
                                          'Authorization':
                                              'Bearer ${currentUser.token}'
                                        };

                                        if (filesPath.isEmpty) {
                                          snackbar(context,
                                              "يجب رفع المخططات الخاصة بمشروعك");
                                        } else {
                                          /*   var response = await MyFatoorah.startPayment(
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
                                    language: ApiLanguage.English,
                                    token: //fatoorahKey!,
                                        "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
                                  ),
                                );
                                if (response.isSuccess) {*/
                                          if (true) {
                                            try {
                                              var request = http.MultipartRequest(
                                                  'POST',
                                                  Uri.parse(
                                                      '$baseUrl/find-constructor'));
                                              request.fields.addAll({
                                                'cityId': cityId,
                                                'requestNature': requestNature,
                                                'requestType': requestType,
                                                'floorsCount':
                                                    ((floorsNameList.indexOf(
                                                                dropDownFloorValue)) +
                                                            1)
                                                        .toString(),

                                                // 'markAsRejected': 'true'
                                                //  'markAsPendingOfferSelection': 'true'
                                              });

                                              filesPath
                                                  .forEach((element) async {
                                                request.files.add(await http
                                                        .MultipartFile
                                                    .fromPath(
                                                        'files[]', element));
                                              });

                                              request.headers.addAll(headers2);

                                              http.StreamedResponse response =
                                                  await request.send();

                                              if (response.statusCode == 201) {
                                                cleanFisrtServiceCache();
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => SuccessPage(
                                                            text1: translateText[
                                                                    "sucess_pay"]![
                                                                language],
                                                            text2: translateText[
                                                                    "text7"]![
                                                                language])),
                                                    (route) => false);
                                              } else {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const NoInternet()),
                                                    (route) => false);
                                              }
                                            } catch (e) {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const NoInternet()),
                                                  (route) => false);
                                            }
                                          }
                                        }
                                      }
                                    } else {
                                      noteAlert(
                                          context, "يجب التسجيل قبل طلب الخدمة",
                                          () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Login()));
                                      });
                                    }
                                  },
                                  child: longButton(
                                      translateText["Askـservice"]![language])),
                              Container(
                                height: 45,
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
      enabled: !(dropDownValue == items[0] &&
          floorsNameList.getRange(6, floorsNameList.length).contains(item)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: (dropDownValue == items[0] &&
                        floorsNameList
                            .getRange(6, floorsNameList.length)
                            .contains(item))
                    ? Colors.grey
                    : maincolor,
                fontSize: 17),
          ),
        ],
      ));
  Widget buildRadioButton(int index, int groupIndex) {
    final isSelected =
        groupIndex == 0 ? groupValue1 == index : groupValue2 == index;

    return InkWell(
      onTap: () {
        if (groupIndex == 0) {
          setFisrtServiceTypeIndex(index);
        } else {
          setFisrtServiceLocationIndex(index);
        }
        setState(() {
          groupIndex == 0 ? groupValue1 = index : groupValue2 = index;
        });
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

normalTextStyle() {
  return TextStyle(fontWeight: FontWeight.w600, color: maincolor, fontSize: 17);
}

textStyle2() {
  return TextStyle(fontWeight: FontWeight.w600, color: maincolor, fontSize: 23);
}

textStyle3() {
  return TextStyle(fontWeight: FontWeight.w600, color: maincolor, fontSize: 20);
}

textStyle4() {
  return TextStyle(
      fontWeight: FontWeight.bold,
      color: maincolor,
      fontSize: language == 0 ? 17 : 14);
}
