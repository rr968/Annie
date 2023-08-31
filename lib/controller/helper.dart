import 'package:build/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import 'constant.dart';

getUserData() async {
  SharedPreferences user = await SharedPreferences.getInstance();
  List<String> userData = user.getStringList("user") ?? [];
  if (userData != []) {
    try {
      currentUser = User(
          token: userData[0],
          name: userData[1],
          email: userData[2],
          phoneNumber: userData[3],
          image: userData[4],
          city: userData[5]);
    } catch (_) {}
  }
}

setIsSignIn(bool value) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool("isSign", value);
  isSign = value;
}

setlanguage(int value) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setInt("language", value);
}
