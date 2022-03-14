import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel extends Model {
  //init textStyle
  double sizeAppBar = 18;
  double sizeTitle = 18;
  double sizeText = 15;
  double sizeTextMini = 13;
  double sizeButton = 16;
  double letterSpacingAppBar = 1.0;
  double letterSpacingTitle = 1.0;
  double letterSpacingText = 0.5;
  double letterSpacingButton = 0.5;

  //final textStyle

  bool dark = false;
  ThemeData themeData = ThemeData(
    // brightness: Brightness.light,
    // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
    // visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(),
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
  );

  ThemeMode themeMode = ThemeMode.dark;

  Color emphasis = Colors.blue.shade800;
  Color detail = Colors.red.shade700;
  Color title = Colors.black;
  Color subtitle = const Color(0xff393e45); //393e45
  Color icon = Colors.grey.shade700;
  Color background = Colors.white;
  Color shadow = Colors.grey.shade200;
  Color buttonMain = Colors.blue;
  Color buttonMainText = Colors.white;
  Color button = Colors.grey.shade200;
  Color buttonText = Colors.black;

  ThemeModel() {
    getDarkMode();
  }

  getDarkMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      dark = prefs.getBool("dark")!;
      updateTheme();
    } catch (e) {
      dark = false;
      notifyListeners();
    }
  }

  updateTheme() {
    if (dark) {
      themeData = ThemeData(
        // brightness: Brightness.dark,
        // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        // visualDensity: VisualDensity.adaptivePlatformDensity,

        brightness: Brightness.dark,
        colorScheme:
            const ColorScheme.dark(primary: Colors.blue), // Color(0xff1d1f27)),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xff1d1f27), //Color(0xff1f1f1f),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff1d1f27), //Color(0xff1f1f1f), //1d1f27
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      );

      themeMode = ThemeMode.light;

      emphasis = Colors.blue.shade500;
      detail = Colors.red.shade700;
      title = Colors.white;
      subtitle = const Color(0xff90a0b5);
      icon = Colors.grey.shade400;
      background = const Color(0xff1d1f27); //Color(0xff1f1f1f);
      shadow = const Color(0xff17191f); //Colors.grey.shade800;
      buttonMain = const Color(0xff09aaff);
      buttonMainText = Colors.white;
      button = const Color(
          0xff2d313d); //383d4c //Colors.grey.shade800; //saturado 1c1e28
      buttonText = Colors.white;

      notifyListeners();
    } else {
      themeData = ThemeData(
        // brightness: Brightness.light,
        // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black),
        // visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      );

      themeMode = ThemeMode.dark;

      emphasis = Colors.blue.shade800;
      detail = Colors.red.shade700;
      title = Colors.black;
      subtitle = const Color(0xff393e45); //393e45
      icon = Colors.grey.shade700;
      background = Colors.white;
      shadow = Colors.grey.shade200;
      buttonMain = Colors.blue;
      buttonMainText = Colors.white;
      button = Colors.grey.shade200;
      buttonText = Colors.black;

      notifyListeners();
    }
  }
}
