// import 'ma'
import 'package:flutter/material.dart';

class TabIndex with ChangeNotifier {
  int index = 0;

  int getIndex() {
    return index;
  }

  void setIndex(int i) {
    index = i;
    notifyListeners();
  }
}
