import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text) {
    if (text == null) return;
    // print("Text is" + text);
    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }

  static showSnackBarSuccess(String? text) {
    if (text == null) return;
    // print("Text is" + text);
    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.green,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
