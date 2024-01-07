import 'package:flutter/material.dart';

//accent EA3557
ThemeData LightThemeData = ThemeData(
    useMaterial3: true,
    primaryColor: const Color(0xFFF85D5D),
    textTheme: const TextTheme(
        labelLarge: TextStyle(
            // color: Color(0xFFEA3557),
            )),
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF7F7F7),
    cardColor: const Color(0xFFF4F4F4),
    unselectedWidgetColor: const Color(0xFFF9FAFB),
    highlightColor: Colors.grey.shade300,
    colorScheme: const ColorScheme.light(
      secondary: Color(0xFFF4CF47),
      onSecondary: Color(0xFFFFFFFF),
      onBackground: Color(0xFF333333),
      tertiary: Color(0xFFFDEBEE),
      background: Color(0xFFFFFFFF),
      onPrimary: Color(0xFFFFFFFF),
      primary: Color(0xFFF4CF47),
      primaryContainer: Color(0XFF302E2C),
      onPrimaryContainer: Color(0xFFFFFFFF),
      onSecondaryContainer: Color(0xFFFFFFFF),
    ));
