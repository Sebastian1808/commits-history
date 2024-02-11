import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_back_button.dart';

PlatformAppBar customAppBarBackButton(String title, context) {
  return PlatformAppBar(
    material: (_, __) => MaterialAppBarData(
      centerTitle: true,
    ),
    leading: const CustomBackButton(),
    title: Text(
      title,
      style: GoogleFonts.nunito(
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      )
    ),
    backgroundColor: Colors.black,
  );
}
