// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:build/view/splash.dart';
import 'package:http/http.dart' as http;
import 'package:build/controller/erroralert.dart';
import 'package:build/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/button.dart';
import '../../controller/constant.dart';
import '../../controller/snackbar.dart';
import '../Language/language.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  bool isEditing = false;
  bool isLoading = false;
  String temporaryImage = currentUser.image;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String _currentSelectedValue = currentUser.city;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<Offset> _offsetAnimation2;
  late Animation<Offset> _offsetAnimation3;
  @override
  void initState() {
    super.initState();
    //to translate city if its store in different language
    if (language == 0) {
      if (!citiesAr.contains(currentUser.city)) {
        _currentSelectedValue = citiesAr[citiesEn.indexOf(currentUser.city)];
      }
    } else {
      if (!citiesEn.contains(currentUser.city)) {
        _currentSelectedValue = citiesEn[citiesAr.indexOf(currentUser.city)];
      }
    }
    emailController.text = currentUser.email;
    nameController.text = currentUser.name;
    phoneController.text = currentUser.phoneNumber;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(.1, .8),
    ));
    _offsetAnimation2 = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      // curve: Curves.easeOut,
      curve: const Interval(0.2, 1.0),
    ));
    _offsetAnimation3 = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(.4, 1),
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      body: Directionality(
        textDirection: language == 0 ? TextDirection.rtl : TextDirection.ltr,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, top: 40),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Align(
                              alignment: Alignment.center,
                              child: Image.asset("assets/Vector-1.png")),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isEditing = true;
                                });
                              },
                              child: Text(
                                isEditing
                                    ? ""
                                    : translateText["modify_account"]![
                                        language],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            isEditing
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        temporaryImage = currentUser.image;
                                        isEditing = false;
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 120),
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              isEditing
                                  ? TextField(
                                      controller: nameController,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        alignLabelWithHint: true,
                                        contentPadding:
                                            const EdgeInsets.all(15),
                                        labelText:
                                            translateText["name"]![language],
                                        labelStyle: const TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        hintText:
                                            translateText["name"]![language],
                                        hintStyle: const TextStyle(
                                            fontSize: 17, color: Colors.black),
                                        enabledBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(18)),
                                            borderSide: BorderSide(
                                                width: 2, color: Colors.grey)),
                                        focusedBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(18),
                                            ),
                                            borderSide: BorderSide(
                                                width: 2, color: Colors.grey)),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                height: isEditing ? 20 : 0,
                              ),
                              SlideTransition(
                                position: _offsetAnimation,
                                child: TextField(
                                  ///////
                                  controller: phoneController,
                                  enabled: isEditing ? true : false,
                                  style: isEditing
                                      ? const TextStyle()
                                      : TextStyle(
                                          color: pinkcolor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    alignLabelWithHint: true,
                                    contentPadding: const EdgeInsets.all(15),
                                    labelText:
                                        translateText["mobileNum"]![language],
                                    labelStyle: const TextStyle(
                                        fontSize: 17, color: Colors.black),
                                    hintText:
                                        translateText["mobileNum"]![language],
                                    hintStyle: const TextStyle(
                                        fontSize: 17, color: Colors.black),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18)),
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.grey)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(18),
                                        ),
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.grey)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SlideTransition(
                                position: _offsetAnimation3,
                                child: TextField(
                                  enabled: isEditing ? true : false,
                                  controller: emailController,
                                  cursorColor: Colors.black,
                                  style: isEditing
                                      ? const TextStyle()
                                      : TextStyle(
                                          color: pinkcolor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    alignLabelWithHint: true,
                                    contentPadding: const EdgeInsets.all(15),
                                    label: SizedBox(
                                      width: 70,
                                      child: Text(
                                        translateText["ِEmail"]![language],
                                        style: const TextStyle(fontSize: 19),
                                      ),
                                    ),
                                    labelStyle: const TextStyle(
                                        fontSize: 17, color: Colors.black),
                                    hintText:
                                        translateText["ِEmail"]![language],
                                    hintStyle: const TextStyle(
                                        fontSize: 17, color: Colors.black),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18)),
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.grey)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(18),
                                        ),
                                        borderSide: BorderSide(
                                            width: 2, color: Colors.grey)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SlideTransition(
                                position: _offsetAnimation2,
                                child: isEditing
                                    ? FormField<String>(
                                        builder:
                                            (FormFieldState<String> state) {
                                          return InputDecorator(
                                            decoration: InputDecoration(
                                              labelText: translateText[
                                                  "country"]![language],
                                              labelStyle: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                              hintText: translateText[
                                                  "country"]![language],
                                              hintStyle: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black),
                                              alignLabelWithHint: true,
                                              contentPadding:
                                                  const EdgeInsets.all(15),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  18)),
                                                      borderSide: BorderSide(
                                                          width: 2,
                                                          color: Colors.grey)),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(18),
                                                      ),
                                                      borderSide: BorderSide(
                                                          width: 2,
                                                          color: Colors.grey)),
                                            ),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                value: _currentSelectedValue,
                                                isDense: true,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    _currentSelectedValue =
                                                        newValue ?? "";
                                                    state.didChange(newValue);
                                                  });
                                                },
                                                items:
                                                    cities.map((String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : TextField(
                                        ///////
                                        controller: TextEditingController(
                                            text: _currentSelectedValue),
                                        enabled: isEditing ? true : false,
                                        style: isEditing
                                            ? const TextStyle()
                                            : TextStyle(
                                                color: pinkcolor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          alignLabelWithHint: true,
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          labelText: translateText["country"]![
                                              language],
                                          labelStyle: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.black),
                                          hintText: translateText["country"]![
                                              language],
                                          hintStyle: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.black),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(18)),
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: Colors.grey)),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(18),
                                                  ),
                                                  borderSide: BorderSide(
                                                      width: 2,
                                                      color: Colors.grey)),
                                        ),
                                      ),
                              ),
                              Container(
                                height: 40,
                              ),
                              isEditing
                                  ? InkWell(
                                      onTap: () async {
                                        String token = currentUser.token;
                                        String name =
                                            nameController.text.trim();
                                        String email =
                                            emailController.text.trim();
                                        String phoneNumber =
                                            phoneController.text.trim();
                                        String image = temporaryImage;
                                        String city =
                                            _currentSelectedValue.trim();

                                        ////////////////////////
                                        try {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          var headers = {
                                            'Accept': 'application/json',
                                            'Content-Type': 'application/json',
                                            'Authorization':
                                                'Bearer ${currentUser.token}'
                                          };
                                          var request = http.MultipartRequest(
                                              'POST',
                                              Uri.parse(
                                                  '$baseUrl/users/update?_method=patch'));
                                          request.fields.addAll({
                                            'name': name,
                                            'email': email,
                                            'cityId': (cities.indexOf(city) + 1)
                                                .toString(),
                                            'phoneNumber': phoneNumber,
                                          });
                                          if (temporaryImage !=
                                              currentUser.image) {
                                            request.files.add(await http
                                                    .MultipartFile
                                                .fromPath(
                                                    'image', temporaryImage));
                                          }
                                          request.headers.addAll(headers);

                                          var response = await request.send();
                                          if (response.statusCode == 200) {
                                            setState(() {
                                              isEditing = false;
                                            });

                                            SharedPreferences pref =
                                                await SharedPreferences
                                                    .getInstance();
                                            pref.setStringList("user", [
                                              token,
                                              name,
                                              email,
                                              phoneNumber,
                                              image,
                                              city
                                            ]).then((value) {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Splash()),
                                                  (route) => false);
                                            });
                                          } else {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            snackbar(context,
                                                response.reasonPhrase ?? "");
                                          }
                                        } catch (e) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          snackbar(
                                              context,
                                              translateText["checkInternet"]![
                                                  language]);
                                        }
                                      },
                                      child: isLoading
                                          ? loadingButton()
                                          : Image.asset(
                                              "assets/save.png",
                                              fit: BoxFit.fill,
                                              height: 55,
                                            ),
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        deleteAlert(context);
                                      },
                                      child: Text(
                                        translateText["Delete_Account"]![
                                            language],
                                        style: TextStyle(
                                            color: maincolor,
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 144),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        if (isEditing) {
                          bool a = await Permission.photos.isGranted;
                          if (a) {
                            XFile? pickedImage = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (pickedImage != null) {
                              setState(() {
                                temporaryImage = pickedImage.path;
                              });
                            }
                          } else {
                            await Permission.photos.request();
                            if (await Permission.photos.isGranted) {
                              XFile? pickedImage = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (pickedImage != null) {
                                setState(() {
                                  temporaryImage = pickedImage.path;
                                });
                              }
                            }
                          }
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              image: !temporaryImage.contains("https://")
                                  ? DecorationImage(
                                      image: FileImage(File(temporaryImage)),
                                      fit: BoxFit.cover)
                                  : DecorationImage(
                                      image: NetworkImage(temporaryImage),
                                      fit: BoxFit.cover),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          isEditing
                              ? Icon(
                                  Icons.edit_outlined,
                                  size: 25,
                                  color: maincolor,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        currentUser.name,
                        style: TextStyle(
                            color: maincolor,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
