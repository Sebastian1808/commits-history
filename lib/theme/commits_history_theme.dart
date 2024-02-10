import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'style.dart';

class CommitsHistoryCupertinoTheme {
  static CupertinoThemeData light() {
    return CupertinoThemeData(
      scaffoldBackgroundColor: CupertinoColors.white,
      primaryColor: Colors.black,
      textTheme: CupertinoTextThemeData(
          textStyle: const TextStyle(color: CupertinoColors.black),
          primaryColor: Colors.amber.shade400
      ),
    );
  }

}

class CommitsHistoryMaterialTheme {
  static ThemeData light() {
    return ThemeData(
      primaryColor: Colors.amber.shade400,
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateColor.resolveWith((states) {
            return Colors.black;
          })
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        elevation: 1.0,
        backgroundColor: Colors.black,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.black45,
      ),
      textTheme: Styles.lightTextTheme,
    );
  }
}