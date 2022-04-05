import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:social_network_application/entities/dto/post_talk_dto.dart';
import 'package:social_network_application/entities/dto/post_talk_group_dto.dart';
import 'package:social_network_application/scoped_model/group_mode.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';

class NewPostModel extends Model {
  static const String base = "https://jonatas-social-network-api.herokuapp.com/";

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  bool load = false;

  newTalkUser({required PostTalkDTO post, required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'posts/post/talk');
    var response = await http.post(
      url,
      headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"},
      body: json.encode(post.toMap()),
    );
    // ignore: avoid_print
    print("newTalkUser: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 201:
        ScopedModel.of<ProfileModel>(context).getAllPosts(context: context);
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

  newTalkGroup({required PostTalkGroupDTO post, required BuildContext context, required BuildContext contextScreenGroup}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'posts/post/talk/group');
    var response = await http.post(
      url,
      headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"},
      body: json.encode(post.toMap()),
    );
    // ignore: avoid_print
    print("newTalkUser: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 201:
        ScopedModel.of<ProfileModel>(context).getAllPosts(context: context);
        ScopedModel.of<GroupModel>(contextScreenGroup).getAllPosts(context: contextScreenGroup);
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
}
