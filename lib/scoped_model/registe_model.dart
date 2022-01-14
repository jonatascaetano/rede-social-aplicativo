import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/dto/user_creation_dto.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/view/login/login.dart';
import 'package:social_network_application/view/my_app.dart';
import 'package:social_network_application/view/register/email.dart';
import 'package:social_network_application/view/register/name.dart';
import 'package:social_network_application/view/register/password.dart';

class RegisterModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  bool load = false;
  late String id;

  saveId({required id, required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("id", id);
    getId(context: context);
  }

  Future<void> getId({required BuildContext context}) async {
    Timer(const Duration(seconds: 4), () async {
      final prefs = await SharedPreferences.getInstance();
      try {
        id = prefs.getString("id")!;
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

  checkInvitation({
    required UserCreationDTO userCreationDTO,
    required BuildContext context,
  }) async {
    load = true;
    notifyListeners();
    try {
      var url = Uri.parse(base +
          'invitations/get/check/invitation/${userCreationDTO.invitationValue!}');
      var response = await http.get(url);
      // ignore: avoid_print
      print(response.statusCode);
      switch (response.statusCode) {
        case 202:
          load = false;
          notifyListeners();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Email(userCreationDTO: userCreationDTO)));
          break;
        case 406:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid invitation')),
          );
          load = false;
          notifyListeners();
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Try again later')),
          );
          load = false;
          notifyListeners();
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Try again later')),
      );
      load = false;
      notifyListeners();
    }
  }

  checkEmail({
    required UserCreationDTO userCreationDTO,
    required BuildContext context,
  }) async {
    load = true;
    notifyListeners();
    try {
      var url =
          Uri.parse(base + 'users/get/check/email/${userCreationDTO.email!}');
      var response = await http.get(url);
      // ignore: avoid_print
      print(response.statusCode);
      switch (response.statusCode) {
        case 202:
          load = false;
          notifyListeners();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Name(userCreationDTO: userCreationDTO)));
          break;
        case 406:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid email')),
          );
          load = false;
          notifyListeners();
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Try again later')),
          );
          load = false;
          notifyListeners();
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Try again later')),
      );
      load = false;
      notifyListeners();
    }
  }

  checkName({
    required UserCreationDTO userCreationDTO,
    required BuildContext context,
  }) async {
    load = true;
    notifyListeners();
    try {
      var url =
          Uri.parse(base + 'users/get/check/name/${userCreationDTO.name!}');
      var response = await http.get(url);
      // ignore: avoid_print
      print(response.statusCode);
      switch (response.statusCode) {
        case 202:
          load = false;
          notifyListeners();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Password(userCreationDTO: userCreationDTO)));
          break;
        case 406:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid name')),
          );
          load = false;
          notifyListeners();
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Try again later')),
          );
          load = false;
          notifyListeners();
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Try again later')),
      );
      load = false;
      notifyListeners();
    }
  }

  checkPassword({
    required UserCreationDTO userCreationDTO,
    required String password,
    required BuildContext context,
  }) async {
    load = true;
    notifyListeners();
    try {
      if (userCreationDTO.password! == password) {
        createAccount(userCreationDTO: userCreationDTO, context: context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        load = false;
        notifyListeners();
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Try again later')),
      );
      load = false;
      notifyListeners();
    }
  }

  createAccount(
      {required UserCreationDTO userCreationDTO,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/post/user');
    //var body = json.encode(userCreationDTO);
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: json.encode(userCreationDTO.toMap()),
    );
    // ignore: avoid_print'EPISODE', avoid_print
    print(response.statusCode);
    switch (response.statusCode) {
      case 201:
        saveId(id: response.body, context: context);
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        load = false;
        notifyListeners();
    }
  }
}
