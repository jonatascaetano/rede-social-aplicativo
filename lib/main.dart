import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/entity_model.dart';
import 'package:social_network_application/scoped_model/episode_model.dart';
import 'package:social_network_application/scoped_model/login_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/registe_model.dart';
import 'package:social_network_application/scoped_model/season_model.dart';
import 'package:social_network_application/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'scoped_model/support/language_model.dart';
import 'scoped_model/support/theme_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      child: ScopedModel<LanguageModel>(
        model: LanguageModel(),
        child: ScopedModel<ProfileModel>(
            model: ProfileModel(),
            child: ScopedModel<RegisterModel>(
              model: RegisterModel(),
              child: ScopedModel<LoginModel>(
                model: LoginModel(),
                child: ScopedModel<EntityModel>(
                  model: EntityModel(),
                  child: ScopedModel<SeasonModel>(
                    model: SeasonModel(),
                    child: ScopedModel<EpisodeModel>(
                      model: EpisodeModel(),
                      child: ScopedModelDescendant<ThemeModel>(
                          builder: (context, child, theme) {
                        return MaterialApp(
                          theme: theme.themeData,
                          themeMode: theme.themeMode,
                          debugShowCheckedModeBanner: false,
                          home: const SplashScreen(),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
