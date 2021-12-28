import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/auxiliar/database_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<DatabaseModel>(
        builder: (context, child, database) {
      return Scaffold(
          body: Stack(
        children: [
          FutureBuilder<void>(
            future: database.getId(context: context),
            builder: (context, snapshot) {
              return const Center(
                  child: Text("Application",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      )));
            },
          ),
        ],
      ));
    });
  }
}
