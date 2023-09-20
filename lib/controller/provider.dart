import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier {
  bool isLoadingChooseOffer = false;
  void setisLoadingChooseOffer(bool value) {
    isLoadingChooseOffer = value;
    notifyListeners();
  }

  bool isLoadingConfirmOffer = false;
  void setisLoadingConfirmOffer(bool value) {
    isLoadingConfirmOffer = value;
    notifyListeners();
  }
}
