import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';

class FollowingModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  List<UserMini> following = [];
  late String id;
  bool load = false;

  FollowingModel({required String idUser}) {
    getFollowwings(idUser: idUser);
    getId();
  }

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id")!;
    return id;
  }

  getFollowwings({required String idUser}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'followers/get/followings/user/$idUser');
    var response = await http.get(url);
    // ignore: avoid_print
    print('getFollowwings: ' + response.statusCode.toString());
    following = [];
    switch (response.statusCode) {
      case 200:
        List<dynamic> list = json.decode(response.body);
        for (var item in list) {
          UserMini userMini = UserMini.fromMap(map: item as Map);
          following.add(userMini);
        }
        load = false;
        notifyListeners();
    }
  }

  removeFollowing(
      {required String idFollowing, required BuildContext context}) async {
    load = true;
    notifyListeners();
    String idFollower = await getId();
    // ignore: avoid_print
    print(idFollower);
    var url = Uri.parse(
        base + 'followers/delete/follower/$idFollower/following/$idFollowing');
    var response = await http.delete(url);
    // ignore: avoid_print
    print('removeFollowing: ' + response.statusCode.toString());
    ScopedModel.of<ProfileModel>(context).getProfile(context: context);
    getFollowwings(idUser: idFollower);
    notifyListeners();
  }
}
