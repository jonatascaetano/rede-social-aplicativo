import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/splash_screen_model.dart';

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
      child: ScopedModelDescendant<SplashScreenModel>(
          builder: (context, child, splashScreen) {
        return Scaffold(
            body: Stack(
          children: [
            const Center(
              child: Text(
                "Application",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
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
      }),
    );
  }
}
