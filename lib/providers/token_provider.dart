import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider extends ChangeNotifier {
  int _token = 100;

  int get token {
    SharedPreferences.getInstance().then((prefs) {
      _token = prefs.getInt('token') ?? 100;
    });
    return _token;
  }

  void setToken(int token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = token;
    prefs.setInt('token', token);
    notifyListeners();
  }
}
