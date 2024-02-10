import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateManager extends ChangeNotifier {
  static const storage = FlutterSecureStorage();

  SharedPreferences? prefs;
  bool _initialized = false;
  bool _loggedIn = false;
  bool _isProjectSelected = false;
  String? token;

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isProjectSelected => _isProjectSelected;
  String? get getToken => token;


  initializeApp() async {
    prefs = await SharedPreferences.getInstance();

    token = await storage.read(key: 'token');

    await Future.delayed(const Duration(milliseconds: 1));

    _initialized = true;

    // If the user has a token saved, it will notify the listeners after login
    if (token != null) {

      await login();
    }
    // else notify that the app has been initialized with loggedIn = false
    else {
      notifyListeners();
    }
  }

  login() async {
    _loggedIn = true;

    notifyListeners();
  }

  void selectProject() {
    _isProjectSelected = true;
    notifyListeners();
  }

  void logout() async {
    await storage.write(key: "token", value: null);
    _loggedIn = false;
    _initialized = false;

    initializeApp();
    notifyListeners();
  }
}