import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/scoped_model/group_mode.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/user_model.dart';
import 'package:http/http.dart' as http;

class WidgetPostMethods {
  static const String base = "https://jonatas-social-network-api.herokuapp.com/";

  static updateLikePost({
    required String idPost,
    required BuildContext? contextUserPage,
    required BuildContext? contextGroupPage,
    required BuildContext? contextProfilePage,
    required bool userPageIsOpen,
    required bool profilePageIsOpen,
    required bool groupPageIsOpen,
  }) async {
    if (userPageIsOpen) {
      ScopedModel.of<UserModel>(contextUserPage!).changeLoad();
    }
    if (groupPageIsOpen) {
      ScopedModel.of<GroupModel>(contextGroupPage!).changeLoad();
    }
    if (profilePageIsOpen) {
      ScopedModel.of<ProfileModel>(contextProfilePage!).changeLoad();
    }

    final prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("id")!;

    var url = Uri.parse(base + 'posts/put/like/post/$idPost/user/$id');
    var response = await http.put(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
    // ignore: avoid_print
    print("updateLikePost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        if (userPageIsOpen) {
          ScopedModel.of<UserModel>(contextUserPage!).changeLoad();
          ScopedModel.of<UserModel>(contextUserPage).getMyPosts(context: contextUserPage);
        }
        if (groupPageIsOpen) {
          ScopedModel.of<GroupModel>(contextGroupPage!).changeLoad();
          ScopedModel.of<GroupModel>(contextGroupPage).getAllPosts(context: contextGroupPage);
        }
        if (profilePageIsOpen) {
          ScopedModel.of<ProfileModel>(contextProfilePage!).changeLoad();
          ScopedModel.of<ProfileModel>(contextProfilePage).getMyPosts(context: contextProfilePage);
          ScopedModel.of<ProfileModel>(contextProfilePage).getAllPosts(context: contextProfilePage);
        }
        break;
      default:
        if (userPageIsOpen) {
          ScopedModel.of<UserModel>(contextUserPage!).changeLoad();
          ScaffoldMessenger.of(contextUserPage).showSnackBar(
            const SnackBar(content: Text('Try again later')),
          );
        }
        if (groupPageIsOpen) {
          ScopedModel.of<GroupModel>(contextGroupPage!).changeLoad();
          ScaffoldMessenger.of(contextGroupPage).showSnackBar(
            const SnackBar(content: Text('Try again later')),
          );
        }
        if (profilePageIsOpen) {
          ScopedModel.of<ProfileModel>(contextProfilePage!).changeLoad();
          ScaffoldMessenger.of(contextProfilePage).showSnackBar(
            const SnackBar(content: Text('Try again later')),
          );
        }
        break;
    }
  }
}
