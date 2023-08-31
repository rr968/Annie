import 'package:build/model/user.dart';

import '../model/services.dart';

const String baseUrl = "https://abni.khisham.com/api";
Map<String, String> headers = {
  'Accept': 'application/json',
};

late User currentUser;
late List<String> cities;
List<String> citiesAr = [];
List<String> citiesEn = [];
late List<String> natures;
late List<String> types;
late List<Services> services;
