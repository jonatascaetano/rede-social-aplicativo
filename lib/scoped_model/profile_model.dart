import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/dto/user_update_dto.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'dart:convert';

import 'package:social_network_application/entities/mini_dto/worker_mini.dart';
import 'package:social_network_application/view/login/login.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  List<WorkerMini> workers = [];
  late UserMini userMini;
  bool profileNull = true;
  bool load = false;
  bool imageIsNull = true;
  late File imageFile;

  // ProfileModel({required BuildContext context}) {
  //   getProfile(context: context);
  //   getWorkers();
  // }

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  getProfile({required BuildContext context}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'users/get/user/$id');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print('getProfile: ' + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var item = json.decode(response.body);
        // ignore: avoid_print
        print(item);
        userMini = UserMini.fromMap(map: item as Map);
        profileNull = false;
        notifyListeners();
        load = false;
        notifyListeners();
        getWorkers();
        break;
      default:
        load = false;
        notifyListeners();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (_) => false);
    }
  }

  getWorkers() async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'users/get/user/$id/workers');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("getWorkersUser: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        workers = [];
        var itens = json.decode(response.body);
        for (var item in itens) {
          WorkerMini workerMini = WorkerMini.fromMap(map: item as Map);
          workers.add(workerMini);
          notifyListeners();
        }
        load = false;
        notifyListeners();
        break;
    }
  }

  loadImage() async {
    load = true;
    notifyListeners();
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(xFile!.path);
    load = false;
    imageIsNull = false;
    notifyListeners();
  }

  removeImage() async {
    load = true;
    notifyListeners();
    load = false;
    imageIsNull = true;
    notifyListeners();
  }

  updateImage(
      {required UserUpdateDTO userUpdateDTO,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    try {
      //--save image firebase -/

      await FirebaseStorage.instance
          .ref()
          .child("profile")
          .child(userMini.id + ".jpg")
          .putFile(imageFile)
          .snapshot
          .ref
          .getDownloadURL()
          .then((value) {
        userUpdateDTO.image = value;
      });

      //**save image firebase */

      //--save image api -/
      var url = Uri.parse(base + 'users/put/image');
      var response = await http
          .put(url, body: json.encode(userUpdateDTO.toMap()), headers: {
        "Accept": "application/json; charset=utf-8",
        "content-type": "application/json; charset=utf-8"
      });
      // ignore: avoid_print
      print("updateImage: " + response.statusCode.toString());
      switch (response.statusCode) {
        case 202:
          getProfile(context: context);
          load = false;
          imageIsNull = true;
          notifyListeners();
          Navigator.pop(context);
          break;
        default:
          load = false;
          imageIsNull = true;
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Try again later')),
          );
          break;
      }
      //**save image api */
    } catch (e) {
      load = false;
      imageIsNull = true;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Try again later')),
      );
    }
  }

  updateName(
      {required UserUpdateDTO userUpdateDTO,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/put/name');
    var response =
        await http.put(url, body: json.encode(userUpdateDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("updateName: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getProfile(context: context);
        load = false;
        notifyListeners();
        Navigator.pop(context);
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  updatePlace(
      {required UserUpdateDTO userUpdateDTO,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/put/place');
    var response =
        await http.put(url, body: json.encode(userUpdateDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("updateCity: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getProfile(context: context);
        load = false;
        notifyListeners();
        Navigator.pop(context);
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  updateDescription(
      {required UserUpdateDTO userUpdateDTO,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/put/description');
    var response =
        await http.put(url, body: json.encode(userUpdateDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("updateDescription: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getProfile(context: context);
        load = false;
        notifyListeners();
        Navigator.pop(context);
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  updateEmail(
      {required UserUpdateDTO userUpdateDTO,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/put/email');
    var response =
        await http.put(url, body: json.encode(userUpdateDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("updateEmail: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getProfile(context: context);
        load = false;
        notifyListeners();
        Navigator.pop(context);
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  updatePassword(
      {required UserUpdateDTO userUpdateDTO,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/put/password');
    var response =
        await http.put(url, body: json.encode(userUpdateDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("updatePassword: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getProfile(context: context);
        load = false;
        notifyListeners();
        Navigator.pop(context);
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  getPost() {}
}
