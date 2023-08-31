// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:build/controller/button.dart';
import 'package:build/view/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../controller/constant.dart';
import '../../controller/erroralert.dart';
import '../../controller/snackbar.dart';
import '../../main.dart';
import '../Language/language.dart';

class ForgetPassWord extends StatefulWidget {
  const ForgetPassWord({super.key});

  @override
  State<ForgetPassWord> createState() => _ForgetPassWordState();
}

class _ForgetPassWordState extends State<ForgetPassWord> {
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 25),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                color: maincolor,
                size: 40,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              "assets/Isolation_Mode.png",
              color: Colors.black54,
              height: 300,
            ),
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                    height: 250,
                    width: 250,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/Vector.png",
                            ),
                            fit: BoxFit.fill)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          translateText["Edit_pass"]![language],
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Center(
                  child: Directionality(
                    textDirection:
                        language == 0 ? TextDirection.rtl : TextDirection.ltr,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: deviceHeight * .07,
                          ),
                          TextField(
                            controller: emailController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(15),
                              hintText: translateText["ِEmail"]![language],
                              hintStyle: const TextStyle(
                                  fontSize: 17, color: Colors.black),
                              labelText: translateText["ِEmail"]![language],
                              labelStyle: const TextStyle(
                                  fontSize: 17, color: Colors.black),
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18)),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                            ),
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          InkWell(
                              onTap: () {
                                if (emailController.text.trim().isEmpty) {
                                  erroralert(context,
                                      translateText["errorField"]![language]);
                                } else {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  forgetPass(emailController.text.trim());
                                }
                              },
                              child: isLoading
                                  ? loadingButton()
                                  : button(translateText["Send"]![language])),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }

  forgetPass(
    String email,
  ) async {
    try {
      var request = await http.post(Uri.parse('$baseUrl/password/email'),
          headers: headers, body: {'email': email});
      if (request.statusCode == 200) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
        sendAlert(context);
      } else {
        setState(() {
          isLoading = false;
        });
        snackbar(context, json.decode(request.body)["message"]);
      }
    } catch (_) {
      setState(() {
        isLoading = false;
      });
      snackbar(context, "error");
    }
  }
}
