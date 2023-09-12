// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

Future<void> setFisrtServiceTypeIndex(int index) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setInt("FisrtServiceBuildTypeIndex", index);
}

Future<int> getFisrtServiceBuildTypeIndex() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt("FisrtServiceBuildTypeIndex") ?? -1;
}

Future<void> setFisrtServiceLocationIndex(int index) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setInt("FisrtServiceLocationIndex", index);
}

Future<int> getFisrtServiceLocationIndex() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt("FisrtServiceLocationIndex") ?? -1;
}

//////////////////
Future<void> setFisrtServiceNatureIndex(int index) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setInt("FisrtServiceNatureIndex", index);
}

Future<int> getFisrtServiceNatureIndex() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt("FisrtServiceNatureIndex") ?? -1;
}

Future<void> setSecondServiceNatureIndex(int index) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setInt("SecondServiceNatureIndex", index);
}

Future<int> getSecondServiceNatureIndex() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt("SecondServiceNatureIndex") ?? -1;
}

//////////////////
Future<void> setFisrtServiceFloorNumber(int index) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setInt("FisrtServiceFloorNumber", index);
}

Future<int> getFisrtServiceFloorNumber() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt("FisrtServiceFloorNumber") ?? -1;
}

Future<void> setSecondServiceFloorNumber(int index) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setInt("SecondServiceFloorNumber", index);
}

Future<int> getSecondServiceFloorNumber() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt("SecondServiceFloorNumber") ?? -1;
}

////////////////////
Future<void> setFisrtServiceFiles(List<String> data) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setStringList("FisrtServiceFiles", data);
}

Future<List<String>> getFisrtServiceFiles() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getStringList("FisrtServiceFiles") ?? [];
}

Future<void> setSecondServiceFiles(List<String> data) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setStringList("SecondServiceFiles", data);
}

Future<List<String>> getSecondServiceFiles() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getStringList("SecondServiceFiles") ?? [];
}

///////////////////
Future<void> cleanFisrtServiceCache() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.remove("FisrtServiceBuildTypeIndex");
  pref.remove("FisrtServiceLocationIndex");
  pref.remove("FisrtServiceNatureIndex");
  pref.remove("FisrtServiceFloorNumber");
  pref.remove("FisrtServiceFiles");
}

Future<void> cleanSecondServiceCache() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  pref.remove("SecondServiceNatureIndex");
  pref.remove("SecondServiceFloorNumber");
  pref.remove("SecondServiceFiles");
}
