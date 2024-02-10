import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 34,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 20,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headline4 = TextStyle(
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headline5 = TextStyle(
    fontSize: 15,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontSize: 17,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontSize: 15,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bodyTextBold = TextStyle(
    fontSize: 15,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static TextTheme lightTextTheme = TextTheme(
    headline1: GoogleFonts.nunito(
        textStyle: headline1,
        color: Colors.black
    ),
    headline2: GoogleFonts.nunito(
        textStyle: headline2,
        color: Colors.black
    ),
    headline3: GoogleFonts.nunito(
        textStyle: headline3,
        color: Colors.black
    ),
    headline4: GoogleFonts.nunito(
        textStyle: headline4,
        color: Colors.black
    ),
    headline5: GoogleFonts.nunito(
        textStyle: headline5,
        color: Colors.black
    ),
    bodyText1: GoogleFonts.nunito(
        textStyle: bodyText1,
        color: Colors.black
    ),
    bodyText2: GoogleFonts.nunito(
        textStyle: bodyText2,
        color: Colors.black
    ),
  );

  static EdgeInsets paddingBody = const EdgeInsets.only(
      top: 5.0,
      right: 20.0,
      left: 20.0,
      bottom: 20.0
  );

  static TextStyle alertButton = GoogleFonts.nunito(
    textStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.amber,
    ),
  );
}
