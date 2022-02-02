import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:social_network_application/entities/dto/comment_dto.dart';
import 'package:social_network_application/entities/mini_dto/comment_mini.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/user_model.dart';

class CommentModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  bool load = false;
  List<CommentMini> comments = [];
  TextEditingController controller = TextEditingController();

  CommentModel({required String idPost, required BuildContext context}) {
    getAllCommentPost(idPost: idPost, context: context);
  }

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  getAllCommentPost(
      {required String idPost, required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'posts/get/post/$idPost/comments');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("getAllCommentPost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        comments = [];
        var itens = json.decode(response.body);
        for (var item in itens) {
          CommentMini commentMini = CommentMini.fromMap(map: item);
          comments.add(commentMini);
          notifyListeners();
        }
        notifyListeners();
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

  addCommentPost({
    required String idPost,
    required BuildContext context,
    required String body,
    required bool screenUser,
  }) async {
    load = true;
    notifyListeners();
    String id = await getId();
    CommentDTO commentDTO = CommentDTO(
      idComment: null,
      idUser: id,
      idPost: idPost,
      body: body,
      release: DateTime.now().toString(),
    );
    var url = Uri.parse(base + 'comments/post/comment');
    var response = await http.post(
      url,
      headers: {
        "Accept": "application/json; charset=utf-8",
        "content-type": "application/json; charset=utf-8"
      },
      body: json.encode(commentDTO.toMap()),
    );
    // ignore: avoid_print
    print("addCommentPost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 201:
        controller.clear();
        getAllCommentPost(idPost: idPost, context: context);
        if (screenUser) {
          ScopedModel.of<UserModel>(context).getMyPosts(context: context);
        }
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

  removeCommentPost(
      {required String idPost,
      required BuildContext context,
      required String idComment}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    CommentDTO commentDTO = CommentDTO(
        idComment: idComment,
        idUser: id,
        idPost: idPost,
        body: null,
        release: DateTime.now().toString());
    var url = Uri.parse(base + 'comments/delete/comment');
    var response = await http.delete(
      url,
      headers: {
        "Accept": "application/json; charset=utf-8",
        "content-type": "application/json; charset=utf-8"
      },
      body: json.encode(commentDTO.toMap()),
    );
    // ignore: avoid_print
    print("removeCommentPost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        getAllCommentPost(idPost: idPost, context: context);
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

  updateLikeComment(
      {required BuildContext context,
      required String idComment,
      required String idPost}) async {
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'comments/put/like/comment/$idComment/user/$id');
    var response = await http.put(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("updateLikePost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getAllCommentPost(idPost: idPost, context: context);
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
