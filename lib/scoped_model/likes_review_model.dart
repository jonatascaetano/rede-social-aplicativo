import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class LikeReviewModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  bool load = false;
  bool likeReviewIsNull = true;
  List<UserMini> users = [];

  LikeReviewModel({required String idReview, required BuildContext context}) {
    getLikesReview(idReview: idReview, context: context);
  }

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  getLikesReview(
      {required String idReview, required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'entitysaves/get/likes/$idReview');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print('getLikesReview: ' + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var item = json.decode(response.body);
        for (var map in item) {
          UserMini userMini = UserMini.fromMap(map: map);
          users.add(userMini);
        }
        load = false;
        likeReviewIsNull = false;
        notifyListeners();
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
}
