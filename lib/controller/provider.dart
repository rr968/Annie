import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier {
  bool isLoadingChooseOffer = false;
  bool contract2Accepted = false;
  void setContract2Accepted(bool value) {
    contract2Accepted = value;
    notifyListeners();
  }

  bool getContract2Accepted() {
    return contract2Accepted;
  }

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
