import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/database_model.dart';
import 'package:social_network_application/scoped_model/language_model.dart';
import 'package:social_network_application/scoped_model/theme_model.dart';
import 'package:social_network_application/view/splash_screen.dart';

void main() {
  runApp(const Model());
}

class Model extends StatefulWidget {
  const Model({Key? key}) : super(key: key);

  @override
  _ModelState createState() => _ModelState();
}

class _ModelState extends State<Model> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ThemeModel>(
        model: ThemeModel(),
        child: ScopedModel<DatabaseModel>(
            model: DatabaseModel(),
            child: ScopedModel<LanguageModel>(
                model: LanguageModel(),
                child: ScopedModelDescendant<ThemeModel>(
                    builder: (context, child, theme) {
                  return MaterialApp(
                      theme: theme.themeData,
                      themeMode: theme.themeMode,
                      debugShowCheckedModeBanner: false,
                      home: const SplashScreen());
                }))));
  }
}
