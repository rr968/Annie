import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/erroralert.dart';
import '../FirstSevice/first_service.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({super.key});

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 55,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " للشكاوي والاقتراحات",
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
                    ),
                    TextField(
                      controller: nameController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.all(15),
                        labelText: "  الاسم ",
                        labelStyle:
                            TextStyle(fontSize: 17, color: Colors.black),
                        hintText: " الاسم ",
                        hintStyle: TextStyle(fontSize: 17, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      ///////
                      controller: phoneController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.all(15),
                        labelText: "  رقم الهاتف ",
                        labelStyle:
                            TextStyle(fontSize: 17, color: Colors.black),
                        hintText: "  رقم الهاتف ",
                        hintStyle: TextStyle(fontSize: 17, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: emailController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.all(15),
                        labelText: "  الايميل ",
                        labelStyle:
                            TextStyle(fontSize: 17, color: Colors.black),
                        hintText: " الايميل  ",
                        hintStyle: TextStyle(fontSize: 17, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: countryController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.all(15),
                        labelText: "  الإمارة  ",
                        labelStyle:
                            TextStyle(fontSize: 17, color: Colors.black),
                        hintText: " الإمارة ",
                        hintStyle: TextStyle(fontSize: 17, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: messageController,
                      cursorColor: Colors.black,
                      maxLines: 4,
                      minLines: 4,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.all(15),
                        labelText: "  الموضوع  ",
                        labelStyle:
                            TextStyle(fontSize: 17, color: Colors.black),
                        hintText: " الموضوع  ",
                        hintStyle: TextStyle(fontSize: 17, color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    InkWell(
                      onTap: () {
                        if (nameController.text.isEmpty ||
                            countryController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            messageController.text.isEmpty ||
                            phoneController.text.isEmpty) {
                          erroralert(context, "يرجىء ملىء جميع الحقول");
                        } else {
                          String encodquery(Map<String, String> par) {
                            return par.entries
                                .map((e) =>
                                    "${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}")
                                .join('&');
                          }

                          final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: "abni@gmail.com",
                              query: encodquery({
                                'subject': "اقتراحات وشكاوى",
                                'body':
                                    "الاسم :${nameController.text}\nرقم الهاتف : ${phoneController.text}\n الايميل : ${emailController.text}\n الامارة :${countryController.text}\n الموضوع:${messageController.text}\n",
                              }));
                          launchUrl(emailLaunchUri);
                        }
                      },
                      child: Image.asset(
                        "assets/send.png",
                        height: 55,
                      ),
                    ),
                    Container(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
