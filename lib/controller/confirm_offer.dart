import 'package:build/Language/language.dart';
import 'package:build/controller/constant.dart';
import 'package:build/controller/no_imternet.dart';
import 'package:build/controller/provider.dart';
import 'package:build/controller/success.dart';
import 'package:build/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

confirmOffer(int requestId, int selectedResponseId, context) async {
  Map<String, String> headers2 = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${currentUser.token}'
  };

  try {
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/confirm-selected-offer'));
    request.fields.addAll({
      'selectedResponseId': selectedResponseId.toString(),
      'requestId': requestId.toString(),
    });

    request.headers.addAll(headers2);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Provider.of<MyProvider>(context, listen: false)
          .setisLoadingConfirmOffer(false);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => SuccessPage(
                  text1: translateText["sucess_confirm"]![language],
                  text2: translateText["text17"]![language])),
          (route) => false);
    } else {
      Provider.of<MyProvider>(context, listen: false)
          .setisLoadingConfirmOffer(false);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NoInternet()),
          (route) => false);
    }
  } catch (_) {
    Provider.of<MyProvider>(context, listen: false)
        .setisLoadingConfirmOffer(false);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const NoInternet()),
        (route) => false);
  }
}
