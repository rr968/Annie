// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:build/controller/button.dart';
import 'package:build/controller/erroralert.dart';
import 'package:build/main.dart';
import 'package:build/view/Auth/forgetpassword.dart';
import 'package:build/view/Auth/signup.dart';
import 'package:build/Language/language.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../controller/constant.dart';
import '../../controller/helper.dart';
import '../../controller/snackbar.dart';
import '../../model/user.dart';
import '../mainpage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  //PhoneNumber phoneNumber = PhoneNumber(isoCode: 'AE');
  bool isVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              "assets/Isolation_Mode.png",
              color: Colors.black54,
              height: 300,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/arrowback.png",
                  color: maincolor,
                  height: 35,
                ),
              ),
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
                          translateText["Welcome_signIn"]![language],
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
                        children: [
                          TextField(
                            ///////
                            controller: phoneController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.all(13),
                              labelText: translateText["mobileNum"]![language],
                              labelStyle: const TextStyle(
                                  fontSize: 17, color: Colors.black),
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18)),
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.grey)),
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                  borderSide:
                                      BorderSide(width: 2, color: Colors.grey)),
                            ),
                          ),
                          /*      Directionality(
                            textDirection: TextDirection.ltr,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 7, horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all()),
                              child: Stack(children: [
                                InternationalPhoneNumberInput(
                                  initialValue: phoneNumber,
                                  selectorConfig: const SelectorConfig(
                                      selectorType:
                                          PhoneInputSelectorType.BOTTOM_SHEET),
                                  formatInput: false,
                                  onInputChanged: (value) {
                                    setState(() {
                                      phoneNumber = value;
                                    });
                                  },
                                  cursorColor: Colors.black,
                                  textAlign: TextAlign.end,
                                  inputDecoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: 10, left: 0),
                                    border: InputBorder.none,
                                    hintText: " رقم الهاتف ",
                                    hintStyle: TextStyle(
                                        fontSize: 17, color: Colors.black),
                                  ),
                                ),
                                Positioned(
                                    left: 90,
                                    top: 8,
                                    child: Container(
                                      height: 40,
                                      width: 1,
                                      color: Colors.black,
                                    ))
                              ]),
                            ),
                          ),
                        */
                          const SizedBox(
                            height: 28,
                          ),
                          TextField(
                            controller: passController,
                            cursorColor: Colors.black,
                            obscureText: isVisible,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    !isVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(13),
                              labelText: translateText["pass"]![language],
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
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetPassWord()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: language == 0
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Text(
                                    translateText["forget_pass"]![language],
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: maincolor,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              if (passController.text.trim().isEmpty ||
                                  passController.text.trim().isEmpty) {
                                erroralert(context,
                                    translateText["errorField"]![language]);
                              } else {
                                setState(() {
                                  isLoading = true;
                                });
                                login();
                              }
                            },
                            child: isLoading
                                ? loadingButton()
                                : longButton(
                                    translateText["signIn"]![language]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                translateText["noAccount"]![language],
                                style: const TextStyle(fontSize: 16),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUp()));
                                },
                                child: Text(
                                  translateText["createAccount"]![language],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: maincolor,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
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

  login() async {
    try {
      var request =
          await http.post(Uri.parse('$baseUrl/login'), headers: headers, body: {
        'phoneNumber': phoneController.text.trim(),
        'password': passController.text.trim()
      });
      if (request.statusCode == 200) {
        Map<String, dynamic> data = json.decode(request.body);

        String token = data["token"];
        String name = data["user"]["name"];
        String email = data["user"]["email"];
        String phoneNumber = data["user"]["phoneNumber"];
        String image = data["user"]["image"];
        String city = data["user"]["city"];
        currentUser = User(
            token: token,
            name: name,
            email: email,
            phoneNumber: phoneNumber,
            image: image,
            city: city);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setStringList(
            "user", [token, name, email, phoneNumber, image, city]);
        setIsSignIn(true).then((v) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
              (route) => false);
        });
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
      snackbar(context, translateText["checkInternet"]![language]);
    }
  }
}
