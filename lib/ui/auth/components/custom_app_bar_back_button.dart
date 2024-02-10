import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'custom_back_button.dart';

PlatformAppBar customAppBarBackButton(String title, context) {
  return PlatformAppBar(
    material: (_, __) => MaterialAppBarData(
      centerTitle: true,
    ),
    leading: const CustomBackButton(),
    title: Text(
      title,
      style: platformThemeData(
        context,
        material: (data) =>
            data.textTheme.headlineMedium?.copyWith(color: Colors.white),
        cupertino: (data) =>
            data.textTheme.navTitleTextStyle.copyWith(color: Colors.white),
      ),
    ),
    backgroundColor: Colors.black,
  );
}
