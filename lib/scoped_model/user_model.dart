import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/mini_dto/post_update_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/entities/mini_dto/worker_mini.dart';
import 'package:social_network_application/enuns/type_post.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/widgets/post/update_post_widget.dart';

class UserModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  late bool showFollowButton = false;
  late bool isFollowing;
  List<WorkerMini> workers = [];
  bool profileNull = true;
  late UserMini userMini;
  bool load = false;
  List<dynamic> myPosts = [];
  late String idUSer;

  UserModel({required String idUser, required BuildContext context}) {
    getWorkersUser(idUser: idUser);
    getProfile(idUser: idUser, context: context);
    checkFollowing(idUser: idUser);
  }

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  getProfile({required String idUser, required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/get/user/$idUser');
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
        load = false;
        notifyListeners();
        getMyPosts(context: context);
    }
  }

  getWorkersUser({required String idUser}) async {
    var url = Uri.parse(base + 'users/get/user/$idUser/workers');
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
        notifyListeners();
        break;
    }
  }

  checkFollowing({required String idUser}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(
        base + 'followers/get/check/following/user/$id/following/$idUser');
    // ignore: avoid_print
    print("follower id: $idUser, following id: $id");
    var response = await http.get(url);
    // ignore: avoid_print
    print("checkFollowing: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        isFollowing = true;
        showFollowButton = true;
        load = false;
        notifyListeners();
        break;
      case 404:
        isFollowing = false;
        showFollowButton = true;
        load = false;
        notifyListeners();
        break;
      default:
        showFollowButton = false;
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
    getProfile(idUser: idFollowing, context: context);
    checkFollowing(idUser: idFollowing);
    notifyListeners();
  }

  addFollowing(
      {required String idFollowing, required BuildContext context}) async {
    load = true;
    notifyListeners();
    String idFollower = await getId();
    // ignore: avoid_print
    print(idFollower);
    var url = Uri.parse(
        base + 'followers/post/follower/$idFollower/following/$idFollowing');
    var response = await http.post(url);
    // ignore: avoid_print
    print('addFollowing: ' + response.statusCode.toString());
    ScopedModel.of<ProfileModel>(context).getProfile(context: context);
    getProfile(idUser: idFollowing, context: context);
    checkFollowing(idUser: idFollowing);
    notifyListeners();
  }

  getMyPosts({required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'users/get/user/${userMini.id}/posts/my');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("getMyPostsUser: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        //posts = [];
        myPosts = [];
        var itens = json.decode(response.body);
        myPosts = itens;
        // for (var item in itens) {
        //   if (item['typePost'] == "UPDATE") {
        //     PostUpdateMini postUpdateMini = PostUpdateMini.fromMap(map: item);
        //     posts.add(postUpdateMini);
        //   }
        // }
        load = false;
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

  updateLikePost(
      {required BuildContext context, required String idPost}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'posts/put/like/post/$idPost/user/$id');
    var response = await http.put(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("updateLikePostUser: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getMyPosts(context: context);
        notifyListeners();
        load = false;
        notifyListeners();
        ScopedModel.of<ProfileModel>(context).getAllPosts(context: context);
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

  removePost({required BuildContext context, required String idPost}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'posts/delete/post/$idPost/user/$id');
    var response = await http.delete(
      url,
      headers: {
        "Accept": "application/json; charset=utf-8",
        "content-type": "application/json; charset=utf-8"
      },
    );
    // ignore: avoid_print
    print("removePost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        getMyPosts(context: context);
        ScopedModel.of<ProfileModel>(context).getAllPosts(context: context);
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

  returnPostWidget(
      {required Map post,
      required bool screenComment,
      required BuildContext contextPage}) {
    // ignore: avoid_print
    switch (post["typePost"]) {
      case TypePost.UPDATE:
        return UpdatePostWidget(
          postUpdateMini: PostUpdateMini.fromMap(map: post),
          screenComment: screenComment,
          screenUser: true,
          contextPage: contextPage,
        );
      default:
    }
  }
}
