import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/mini_dto/invitation_mini.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/authentication/login.dart';
import 'package:social_network_application/view/tabs/home/new_entity.dart';

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
    ScopedModel.of<ProfileModel>(context).postsAreNull = true;
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
    load = false;
    notifyListeners();
  }

  //--invitation

  //-dark mode
  getDarkMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      isDark = prefs.getBool("dark")!;
      notifyListeners();
    } catch (e) {
      isDark = false;
      notifyListeners();
    }
  }

  saveDarkMode({required bool dark, required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("dark", dark);
    ScopedModel.of<ThemeModel>(context).getDarkMode();
    getDarkMode();
  }

  //--dark mode

  //--new entity
  showListEntitiesBottomSheet(BuildContext context) {
    showModalBottomSheet<dynamic>(
        //isScrollControlled: true,
        context: context,
        builder: (context) {
          return ScopedModelDescendant<ThemeModel>(
              builder: (context, child, theme) {
            return BottomSheet(
                backgroundColor: theme.background,
                onClosing: () {},
                builder: (context) {
                  return GridView.count(
                    childAspectRatio: 1.0 / 1.6,
                    crossAxisCount: 3,
                    children: LanguageModel().typeEntities.map((e) {
                      return GestureDetector(
                        child: Container(
                          color: Colors.transparent,
                          margin: const EdgeInsets.all(4.0),
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                child: Icon(
                                  LanguageModel().typeEntitiesIcon[
                                      LanguageModel().typeEntities.indexOf(e)],
                                  size: 30.0,
                                  color: theme.buttonText,
                                ),
                                backgroundColor: theme.button,
                                radius: 40.0,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                e,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: theme.buttonText,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewEntity(
                                        typeEntity: e,
                                      )));
                        },
                      );
                    }).toList(),
                  );
                });
          });
        });
  }
}
