import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

PlatformAppBar customAppBar(String title, context) {
  return PlatformAppBar(
    material: (_, __) => MaterialAppBarData(
      centerTitle: true,
    ),
    title: Text(
      title,
      style: GoogleFonts.nunito(
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    backgroundColor: Colors.grey[850],
  );
}
