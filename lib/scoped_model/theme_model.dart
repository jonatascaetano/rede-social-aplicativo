import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ThemeModel extends Model {
  ThemeData themeData = ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.purple,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.purple,
          )));

  ThemeMode themeMode = ThemeMode.dark;
}
