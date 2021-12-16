import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/view/login.dart';
import 'dart:convert';

import 'package:social_network_application/view/my_app.dart';

class DatabaseModel extends Model {
  String id = '';

  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  saveId({required id, required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("id", id);
    getId(context: context);
  }

  getId({required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      id = prefs.getString("id")!;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyApp()));
    } catch (e) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    }
  }

  removeId({required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("id");
    getId(context: context);
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    var url =
        Uri.parse(base + 'users/get/login/email/$email/password/$password');
    var response = await http.get(url);
    id = response.body;
    switch (response.statusCode) {
      case 200:
        saveId(id: id, context: context);
        // ignore: avoid_print
        print('autorizado: id ' + id);
        break;
      case 401:
        // ignore: avoid_print
        print('não autorizado');
        break;
      case 404:
        // ignore: avoid_print
        print('não econtrado');
        break;
      default:
    }
  }
}
