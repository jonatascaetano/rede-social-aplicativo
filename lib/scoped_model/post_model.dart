import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/mini_dto/post_update_mini.dart';
import 'package:http/http.dart' as http;
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/user_model.dart';

class PostModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  late PostUpdateMini postUpdateMini;
  bool postUpdateMiniIsNull = true;
  int likeQuantity = 0;
  int commentQuantity = 0;

  PostModel(
      {required BuildContext context,
      required String idPost,
      required int likes,
      required int comments}) {
    likeQuantity = likes;
    commentQuantity = comments;
    getPostUpdateMini(context: context, idPost: idPost);
  }

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  getPostUpdateMini(
      {required BuildContext context, required String idPost}) async {
    notifyListeners();
    var url = Uri.parse(base + 'posts/get/post/$idPost');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("getPostUpdateMini: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var item = json.decode(response.body);
        postUpdateMini = PostUpdateMini.fromMap(map: item);
        likeQuantity = postUpdateMini.likeQuantity;
        commentQuantity = postUpdateMini.commentQuantity;
        notifyListeners();
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  updateLikePost(
      {required BuildContext context, required String idPost}) async {
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'posts/put/like/post/$idPost/user/$id');
    var response = await http.put(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("updateLikePost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getPostUpdateMini(context: context, idPost: idPost);
        ScopedModel.of<ProfileModel>(context).getAllPosts(context: context);
        ScopedModel.of<UserModel>(context).getMyPosts(context: context);
        notifyListeners();
        break;
      default:
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }
}
