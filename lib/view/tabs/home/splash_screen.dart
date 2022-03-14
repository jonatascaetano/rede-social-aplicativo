import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/splash_screen_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<SplashScreenModel>(
      model: SplashScreenModel(context: context),
      child: ScopedModelDescendant<SplashScreenModel>(builder: (context, child, splashScreen) {
        return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
          return Scaffold(
              body: Stack(
            children: [
              Center(
                child: Text(
                  "Bundle",
                  style: TextStyle(
                    color: theme.title,
                    fontSize: 36,
                    letterSpacing: 4.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              splashScreen.load
                  ? Positioned(
                      bottom: 0.1,
                      child: SizedBox(
                        height: 5.0,
                        width: MediaQuery.of(context).size.width,
                        child: const LinearProgressIndicator(),
                      ),
                    )
                  : Container(),
            ],
          ));
        });
      }),
    );
  }
}
