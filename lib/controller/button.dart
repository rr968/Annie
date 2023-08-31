import 'package:flutter/material.dart';

import '../main.dart';

Widget button(String text) {
  return Container(
    height: 58,
    width: 190,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff4C2963),
          Color(0xffAA277B),
        ],
      ),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget longButton(String text) {
  return Container(
    height: 55,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff4C2963),
          Color(0xffAA277B),
        ],
      ),
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

Widget loadingButton() {
  return Container(
    height: 55,
    width: 55,
    decoration: BoxDecoration(
        color: maincolor, borderRadius: BorderRadius.circular(10)),
    child: const Center(
        child: CircularProgressIndicator(
      color: Colors.white,
    )),
  );
}
