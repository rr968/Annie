import 'package:build/model/pricing.dart';
import 'package:build/model/user.dart';

import '../model/services.dart';

const String baseUrl = "https://abni.khisham.com/api";
Map<String, String> headers = {
  'Accept': 'application/json',
};
List<Pricing> floors = [];
List<String> floorsNameList = [];
String contactPhone = "971675987343";
String contactEmail = "abni@gmail.com";
late User currentUser;
late List<String> cities;
List<String> citiesAr = [];
List<String> citiesEn = [];
late List<String> natures;
late List<String> types;
late List<Services> services;
String? notificationToken;
