import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/mini_dto/invitation_mini.dart';
import 'package:social_network_application/view/login/login.dart';

class MenuModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";
  bool load = false;
  bool invitationIsNull = true;
  bool isDark = false;
  late String invitation = '';
  late InvitationMini invitationMini;

  MenuModel({required BuildContext context}) {
    getInvitation(context: context);
    getDarkMode();
  }

  //-exit

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  removeId({required BuildContext context}) async {
    load = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("id");
    load = false;
    notifyListeners();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => const Login()), (_) => false);
  }

  removeInvitation() async {
    load = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("invitation");
    load = false;
    notifyListeners();
  }

  logOut({required BuildContext context}) async {
    load = true;
    notifyListeners();
    Timer(const Duration(seconds: 4), () {
      removeInvitation();
      removeId(context: context);
    });
  }

  //--exit

  //-invitation

  getInvitation({required BuildContext context}) async {
    load = true;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      invitation = prefs.getString("invitation")!;
      load = false;
      notifyListeners();
    } catch (e) {
      try {
        String id = await getId();
        var url = Uri.parse(base + 'users/get/user/$id/invitation');
        var response = await http.get(url, headers: {
          "Accept": "application/json; charset=utf-8",
          "content-type": "application/json; charset=utf-8"
        });
        // ignore: avoid_print
        print('getInvitation: ' + response.statusCode.toString());
        switch (response.statusCode) {
          case 200:
            var item = json.decode(response.body);
            invitationMini = InvitationMini.fromMap(map: item);
            invitation = invitationMini.value!;
            saveInvitation(invitation: invitation);
            break;
          default:
        }
      } catch (e) {
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
      }
    }
  }

  saveInvitation({required String invitation}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("invitation", invitation);
    invitationIsNull = false;
    notifyListeners();
  }

  //--invitation

  //-dark mode
  getDarkMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      isDark = prefs.getBool("isDark")!;
      notifyListeners();
    } catch (e) {
      isDark = false;
      notifyListeners();
    }
  }

  saveDarkMode({required bool darkMode}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDark", darkMode);
    getDarkMode();
  }

  //--dark mode
}
