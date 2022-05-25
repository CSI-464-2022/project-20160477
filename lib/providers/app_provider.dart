// import 'ma'
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  bool isNewAccount = false;
  String recipientEmail='';
  bool getIsNew() {
    return isNewAccount;
  }

  void setIsNew(bool i) {
    isNewAccount = i;
    notifyListeners();
  }

  String getRecipientEmail()=>recipientEmail;

  void setRecipientEmail(String email){
    recipientEmail=email;
    notifyListeners();
  }
}
