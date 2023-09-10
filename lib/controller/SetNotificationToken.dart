// ignore_for_file: file_names

import 'package:build/controller/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

setNotificationTokenApi() async {
  try {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${currentUser.token}'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/update-device-token'));
    request.fields.addAll({'token': notificationToken ?? ""});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("SetNotificationToken", true);
      //print(await response.stream.bytesToString());
    } else {}
  } catch (_) {}
}
