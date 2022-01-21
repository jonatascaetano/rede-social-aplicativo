import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/view/authentication/login.dart';
import 'package:social_network_application/view/my_app.dart';
import 'package:http/http.dart' as http;

class LoginModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  bool load = false;

  saveId({required id, required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("id", id);
    ScopedModel.of<ProfileModel>(context).getProfile(context: context);
    getId(context: context);
  }

  Future<void> getId({required BuildContext context}) async {
    Timer(const Duration(seconds: 4), () async {
      final prefs = await SharedPreferences.getInstance();
      try {
        // ignore: unused_local_variable
        String id = prefs.getString("id")!;
        ScopedModel.of<ProfileModel>(context).getProfile(context: context);
        //ScopedModel.of<ProfileModel>(context).getWorkers();
        load = false;
        notifyListeners();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MyApp()),
            (_) => false);
      } catch (e) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (_) => false);
      }
    });
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    try {
      var url =
          Uri.parse(base + 'users/get/login/email/$email/password/$password');
      var response = await http.get(url);
      String id = response.body;
      switch (response.statusCode) {
        case 200:
          saveId(id: id, context: context);
          // ignore: avoid_print
          print('autorizado: id ' + id);
          break;
        case 401:
          // ignore: avoid_print
          print('não autorizado');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect password')),
          );
          load = false;
          notifyListeners();
          break;
        case 404:
          // ignore: avoid_print
          print('não econtrado');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email not registered')),
          );
          load = false;
          notifyListeners();
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Try again later')),
          );
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Try again later')),
      );
      load = false;
      notifyListeners();
    }
  }
}
