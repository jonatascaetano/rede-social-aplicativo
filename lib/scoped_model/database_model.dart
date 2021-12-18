import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/dto/user_creation_dto.dart';
import 'package:social_network_application/view/login.dart';
import 'dart:convert';

import 'package:social_network_application/view/my_app.dart';
import 'package:social_network_application/view/profile.dart';
import 'package:social_network_application/view/register/email.dart';
import 'package:social_network_application/view/register/name.dart';
import 'package:social_network_application/view/register/password.dart';

class DatabaseModel extends Model {
  String id = '';

  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  saveId({required id, required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("id", id);
    getId(context: context);
  }

  Future<void> getId({required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      id = prefs.getString("id")!;
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => const MyApp()), (_) => false);
    } catch (e) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => const Login()), (_) => false);
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
    try {
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect password')),
          );
          break;
        case 404:
          // ignore: avoid_print
          print('não econtrado');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email not registered')),
          );
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
    }
  }

  checkInvitation({
    required UserCreationDTO userCreationDTO,
    required BuildContext context,
  }) async {
    try {
      var url = Uri.parse(base +
          'invitations/get/check/invitation/${userCreationDTO.invitationValue!}');
      var response = await http.get(url);
      // ignore: avoid_print
      print(response.statusCode);
      switch (response.statusCode) {
        case 202:
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
    }
  }

  checkEmail({
    required UserCreationDTO userCreationDTO,
    required BuildContext context,
  }) async {
    try {
      var url =
          Uri.parse(base + 'users/get/check/email/${userCreationDTO.email!}');
      var response = await http.get(url);
      // ignore: avoid_print
      print(response.statusCode);
      switch (response.statusCode) {
        case 202:
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
    }
  }

  checkName({
    required UserCreationDTO userCreationDTO,
    required BuildContext context,
  }) async {
    try {
      var url =
          Uri.parse(base + 'users/get/check/name/${userCreationDTO.name!}');
      var response = await http.get(url);
      // ignore: avoid_print
      print(response.statusCode);
      switch (response.statusCode) {
        case 202:
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
    }
  }

  checkPassword({
    required UserCreationDTO userCreationDTO,
    required String password,
    required BuildContext context,
  }) async {
    try {
      if (userCreationDTO.password! == password) {
        var url = Uri.parse(base + 'users/post/user');
        //var body = json.encode(userCreationDTO);
        var response = await http.post(
          url,
          headers: {"Content-type": "application/json; charset=UTF-8"},
          body: json.encode(userCreationDTO.toMap()),
        );
        // ignore: avoid_print
        print(response.statusCode);
        switch (response.statusCode) {
          case 201:
            saveId(id: response.body, context: context);
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Try again later')),
            );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Try again later')),
      );
    }
  }

  //profile

  Future<Map<String, dynamic>> getProfile({required String id}) async {
    var url = Uri.parse(base + 'users/get/user/$id');
    var response = await http.get(url);
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic>? map = json.decode(response.body);
        return map!;
      case 400:
        return {};
      default:
        return {};
    }
  }

  Future<bool> getPost() async {
    return true;
  }

  Future<bool> checkFollowing(
      {required String id, required String idFollowing}) async {
    bool follow = false;
    var url = Uri.parse(
        base + 'followers/get/check/following/user/$id/following/$idFollowing');
    // ignore: avoid_print
    print("follower id: $id, following id: ${this.id}");
    await http.get(url).then((value) {
      // ignore: avoid_print
      print("follow: " + value.statusCode.toString());
      switch (value.statusCode) {
        case 200:
          follow = true;
          break;
        case 404:
          follow = false;
          break;
      }
    });
    return follow;
  }

  //search

  Future<Set<String>>? getByNameSuggestions(String text) async {
    Set<String>? found = {};
    try {
      var url = Uri.parse(base + 'users/get/users/name?name=$text');
      var response = await http.get(url);
      // ignore: avoid_print
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (var object in list) {
            found.add(object["name"]!);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    try {
      var url = Uri.parse(base + 'entities/get/entities/name?name=$text');
      var response = await http.get(url);
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (var object in list) {
            found.add(object["name"]!);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    try {
      var url = Uri.parse(base + 'seasons/get/seasons/name?name=$text');
      var response = await http.get(url);
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (var object in list) {
            found.add(object["name"]!);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    try {
      var url = Uri.parse(base + 'episodes/get/episodes/name?name=$text');
      var response = await http.get(url);
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (var object in list) {
            found.add(object["name"]!);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return found;
  }

  Future<List<Map>> getByNameResult(String text, String id) async {
    List<Map>? found = [];
    try {
      var url = Uri.parse(base + 'users/get/users/name?name=$text');
      var response = await http.get(url);
      // ignore: avoid_print
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (var map in list) {
            if (map['id'] != id) {
              found.add(map);
            }
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    try {
      var url = Uri.parse(base + 'entities/get/entities/name?name=$text');
      var response = await http.get(url);
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (Map map in list) {
            found.add(map);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    try {
      var url = Uri.parse(base + 'seasons/get/seasons/name?name=$text');
      var response = await http.get(url);
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (Map map in list) {
            found.add(map);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    try {
      var url = Uri.parse(base + 'episodes/get/episodes/name?name=$text');
      var response = await http.get(url);
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (Map map in list) {
            found.add(map);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return found;
  }

  void goToViewObject({required Map map, required BuildContext context}) {
    switch (map['typeEntity']) {
      case 0:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Profile(id: map['id'], isUser: false)));
        break;
      default:
        // ignore: avoid_print
        print(map['typeEntity']);
    }
  }

  popupMenuButtonSelect({required String item, required BuildContext context}) {
    // ignore: avoid_print
    print(item);
    switch (item) {
      case 'exit':
        removeId(context: context);
        break;
      default:
    }
  }
}
