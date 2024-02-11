import 'dart:async';

import 'package:commits_history/helpers/parse_string_to_bool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateManager extends ChangeNotifier {
  static const storage = FlutterSecureStorage();

  SharedPreferences? prefs;
  bool _initialized = false;
  bool _loggedIn = false;
  bool _isProjectSelected = false;
  bool _isDefaultProject = false;
  String? token;

  String _projectName = "";
  String _projectOwner = "";

  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isProjectSelected => _isProjectSelected;
  bool get isDefaultProject => _isDefaultProject;
  String? get getToken => token;
  String? get projectName => _projectName;
  String? get projectOwner => _projectOwner;


  initializeApp() async {
    prefs = await SharedPreferences.getInstance();

    token = await storage.read(key: 'token');
    _isDefaultProject = parseStringToBool(await storage.read(key: 'isDefaultProject') ?? '');

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

  void setDefaultProject() {
    _isDefaultProject = true;

    notifyListeners();
  }

  login() async {
    _loggedIn = true;

    if (_isDefaultProject) {
      viewDefaultProject();
    }

    notifyListeners();
  }

  void selectProject(String projectName, String projectOwner) async {
    _isProjectSelected = true;

    _projectName = projectName;
    _projectOwner = projectOwner;
    notifyListeners();
  }

  void viewDefaultProject() async {
    _isProjectSelected = true;
    _isDefaultProject = true;

    await storage.write(key: 'isDefaultProject', value: "true");

    _projectName = dotenv.env['REPO_NAME'] ?? "Default Project";
    _projectOwner = dotenv.env['REPO_OWNER'] ?? "";

    notifyListeners();
  }

  bool canResetProject() {
    if (!_isDefaultProject) {
      _isProjectSelected = false;
      _projectName = "";
      _projectOwner = "";

      notifyListeners();

      return true;
    } else {
      return false;
    }
  }

   logout() async {
    await storage.write(key: "token", value: null);
    await storage.write(key: "isDefaultProject", value: null);

    _loggedIn = false;
    _isProjectSelected = false;
    _isDefaultProject = false;
    _projectName = "";
    _projectOwner = "";
    _initialized = false;

    initializeApp();
    notifyListeners();
  }
}