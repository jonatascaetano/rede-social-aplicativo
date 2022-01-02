import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/view/login/login.dart';
import 'package:social_network_application/view/my_app.dart';

class SplashScreenModel extends Model {
  SplashScreenModel({required BuildContext context}) {
    getId(context: context);
  }

  bool load = false;
  late String id;

  Future<void> getId({required BuildContext context}) async {
    load = true;
    notifyListeners();
    Timer(const Duration(seconds: 4), () async {
      try {
        final prefs = await SharedPreferences.getInstance();
        id = prefs.getString("id")!;
        ScopedModel.of<ProfileModel>(context).getProfile(context: context);
        ScopedModel.of<ProfileModel>(context).getWorkers();
        load = false;
        notifyListeners();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MyApp()),
            (_) => false);
      } catch (e) {
        load = false;
        notifyListeners();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (_) => false);
      }
    });
  }
}
