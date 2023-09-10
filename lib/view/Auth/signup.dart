// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:build/controller/erroralert.dart';
import 'package:build/main.dart';
import 'package:build/view/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/button.dart';
import '../../controller/constant.dart';
import '../../controller/helper.dart';
import '../../controller/snackbar.dart';
import '../../model/user.dart';
import '../../Language/language.dart';
import '../mainpage.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController vpassController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isShowPass1 = true;
  bool isShowPass2 = true;

  bool isLoading = false;
  String _currentSelectedValue = cities[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                    height: 240,
                    width: 240,
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
                          translateText["Welcome_signUp"]![language],
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
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          Container(
                            height: 10,
                          ),
                          TextField(
                            controller: nameController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              alignLabelWithHint: true,
                              contentPadding: const EdgeInsets.all(10),
                              label: SizedBox(
                                width: 70,
                                child: Row(
                                  children: [
                                    Text(
                                      translateText["name"]![language],
                                      style: const TextStyle(fontSize: 19),
                                    ),
                                    const Text(
                                      "*",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
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
                          const SizedBox(
                            height: 25,
                          ),
                          TextField(
                            ///////
                            controller: phoneController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              alignLabelWithHint: true,
                              contentPadding: const EdgeInsets.all(10),
                              label: SizedBox(
                                width: 155,
                                child: Row(
                                  children: [
                                    Text(
                                      translateText["mobileNum"]![language],
                                      style: const TextStyle(fontSize: 19),
                                    ),
                                    const Text(
                                      "*",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
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
                          const SizedBox(
                            height: 25,
                          ),
                          FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: InputDecoration(
                                  label: SizedBox(
                                    width: 85,
                                    child: Row(
                                      children: [
                                        Text(
                                          translateText["country"]![language],
                                          style: const TextStyle(fontSize: 19),
                                        ),
                                        const Text(
                                          "*",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                  alignLabelWithHint: true,
                                  contentPadding: const EdgeInsets.all(10),
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(18)),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.grey)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(18),
                                      ),
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.grey)),
                                  labelStyle: const TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _currentSelectedValue,
                                    isDense: true,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _currentSelectedValue = newValue ?? "";
                                        state.didChange(newValue);
                                      });
                                    },
                                    items: cities.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextField(
                            controller: passController,
                            cursorColor: Colors.black,
                            obscureText: isShowPass1,
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isShowPass1 = !isShowPass1;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    !isShowPass1
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              alignLabelWithHint: true,
                              contentPadding: const EdgeInsets.all(10),
                              label: SizedBox(
                                width: 120,
                                child: Row(
                                  children: [
                                    Text(
                                      translateText["pass"]![language],
                                      style: const TextStyle(fontSize: 19),
                                    ),
                                    const Text(
                                      "*",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
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
                          const SizedBox(
                            height: 25,
                          ),
                          TextField(
                            controller: vpassController,
                            cursorColor: Colors.black,
                            obscureText: isShowPass2,
                            decoration: InputDecoration(
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isShowPass2 = !isShowPass2;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    !isShowPass2
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              alignLabelWithHint: true,
                              contentPadding: const EdgeInsets.all(10),
                              label: SizedBox(
                                width: 175,
                                child: Row(
                                  children: [
                                    Text(
                                      translateText["confirmPass"]![language],
                                      style: const TextStyle(fontSize: 19),
                                    ),
                                    const Text(
                                      "*",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
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
                          const SizedBox(
                            height: 25,
                          ),
                          TextField(
                            controller: emailController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              alignLabelWithHint: true,
                              contentPadding: const EdgeInsets.all(10),
                              label: SizedBox(
                                width: 80,
                                child: Row(
                                  children: [
                                    Text(
                                      translateText["ِEmail"]![language],
                                      style: const TextStyle(fontSize: 19),
                                    ),
                                    const Text(
                                      "*",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
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
                          const SizedBox(
                            height: 25,
                          ),
                          InkWell(
                            onTap: () {
                              String name = nameController.text.trim();
                              String email = emailController.text.trim();
                              String password = passController.text.trim();
                              String passwordConfirmation =
                                  vpassController.text.trim();
                              String phoneNumber = phoneController.text.trim();

                              String cityId =
                                  (cities.indexOf(_currentSelectedValue) + 1)
                                      .toString();

                              if (name.isEmpty ||
                                  phoneNumber.length < 6 ||
                                  password.isEmpty ||
                                  passwordConfirmation.isEmpty ||
                                  email.isEmpty ||
                                  cityId.isEmpty) {
                                erroralert(context,
                                    translateText["errorField"]![language]);
                              } else {
                                setState(() {
                                  isLoading = true;
                                });

                                signUp(name, email, password,
                                    passwordConfirmation, phoneNumber, cityId);
                              }
                            },
                            child: isLoading
                                ? loadingButton()
                                : longButton(
                                    translateText["createAccount"]![language]),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                translateText["haveAccount"]![language],
                                style: const TextStyle(fontSize: 16),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()));
                                },
                                child: Text(
                                  translateText["signIn"]![language],
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: maincolor,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 70,
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

  signUp(
    String name,
    String email,
    String password,
    String passwordConfirmation,
    String phoneNumber,
    String cityId,
  ) async {
    try {
      var request = await http
          .post(Uri.parse('$baseUrl/register'), headers: headers, body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'phoneNumber': phoneNumber,
        'cityId': cityId
      });

      if (request.statusCode == 201) {
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
        Map errors = json.decode(request.body)["errors"];

        if (errors.containsKey("email")) {
          snackbar(context, errors["email"].toString());
        } else if (errors.containsKey("password")) {
          snackbar(context, errors["password"].toString());
        } else if (errors.containsKey("phoneNumber")) {
          snackbar(context, errors["phoneNumber"].toString());
        } else if (errors.containsKey("cityId")) {
          snackbar(context, errors["cityId"].toString());
        } else {
          snackbar(context, errors.toString());
        }
      }
    } catch (_) {
      setState(() {
        isLoading = false;
      });
      snackbar(context, translateText["checkInternet"]![language]);
    }

    // print(request.body);
  }
}
