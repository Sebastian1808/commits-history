import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'style.dart';

class CommitsHistoryCupertinoTheme {
  static CupertinoThemeData light() {
    return const CupertinoThemeData(
      scaffoldBackgroundColor: CupertinoColors.white,
      primaryColor: Colors.black,
      textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(color: CupertinoColors.black),
          primaryColor: Colors.blueGrey
      ),
    );
  }

}

class CommitsHistoryMaterialTheme {
  static ThemeData light() {
    return ThemeData(
      primaryColor: Colors.blueGrey,
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