import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  var json = {
    "email": "email",
    "password": "password"
  };

  void setJson(String email, String password) {
    json = {
      "email": email,
      "password": password
    };
    notifyListeners();
  }

  Map<String, String> getIndex() {
    return json;
  }

  String? getEmail() {
    return json['email'];
    // notifyListeners();
  }

  String? getPassword() {
    return json['password'];
    // notifyListeners();
  }
}
