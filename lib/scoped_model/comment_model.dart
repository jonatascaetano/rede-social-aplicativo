import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:social_network_application/entities/dto/comment_dto.dart';
import 'package:social_network_application/entities/mini_dto/comment_mini.dart';
import 'package:social_network_application/entities/mini_dto/post_talk_group_mini.dart';
import 'package:social_network_application/entities/mini_dto/post_talk_mini.dart';
import 'package:social_network_application/entities/mini_dto/post_update_mini.dart';
import 'package:social_network_application/enuns/type_comment.dart';
import 'package:social_network_application/enuns/type_post.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/user_model.dart';

import 'support/theme_model.dart';

class CommentModel extends Model {
  static const String base = "https://jonatas-social-network-api.herokuapp.com/";

  bool load = false;
  List<CommentMini> comments = [];
  TextEditingController controller = TextEditingController();
  late PostUpdateMini postUpdateMini;
  late PostTalkMini postTalkMini;
  late PostTalkGroupMini postTalkGroupMini;
  bool postUpdateMiniIsNull = true;
  bool postTalkMiniIsNull = true;
  bool postTalkGroupMiniIsNul = true;
  int likeQuantity = 0;
  int commentQuantity = 0;

  CommentModel({required String idPost, required BuildContext context, required int likes, required int comments}) {
    likeQuantity = likes;
    commentQuantity = comments;
    getPost(context: context, idPost: idPost);
    getAllCommentPost(idPost: idPost, context: context);
  }

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  getPost({required BuildContext context, required String idPost}) async {
    load = true;
    notifyListeners();
    String idUser = await getId();
    var url = Uri.parse(base + 'posts/get/post/$idPost/user/$idUser');
    var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
    // ignore: avoid_print
    print("getPost***: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var item = json.decode(response.body);
        switch (item["typePost"]) {
          case TypePost.UPDATE:
            postUpdateMini = PostUpdateMini.fromMap(map: item);
            likeQuantity = postUpdateMini.likeQuantity;
            commentQuantity = postUpdateMini.commentQuantity;
            postUpdateMiniIsNull = false;
            notifyListeners();
            break;
          case TypePost.TALK_USER:
            postTalkMini = PostTalkMini.fromMap(map: item);
            likeQuantity = postTalkMini.likeQuantity;
            commentQuantity = postTalkMini.commentQuantity;
            postTalkMiniIsNull = false;
            notifyListeners();
            break;
          case TypePost.TALK_GROUP:
            postTalkGroupMini = PostTalkGroupMini.fromMap(map: item);
            likeQuantity = postTalkGroupMini.likeQuantity;
            commentQuantity = postTalkGroupMini.commentQuantity;
            postTalkGroupMiniIsNul = false;
            notifyListeners();
            break;
          default:
        }
        load = false;
        notifyListeners();

        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  getAllCommentPost({required String idPost, required BuildContext context}) async {
    load = true;
    notifyListeners();
    String idUser = await getId();
    var url = Uri.parse(base + 'posts/get/post/$idPost/comments/user/$idUser');
    var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
    // ignore: avoid_print
    print("getAllCommentPost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        comments = [];
        var itens = json.decode(response.body);
        for (var item in itens) {
          CommentMini commentMini = CommentMini.fromMap(map: item);
          comments.add(commentMini);
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

  updateLikePost({required BuildContext context, required String idPost}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'posts/put/like/post/$idPost/user/$id');
    var response = await http.put(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
    // ignore: avoid_print
    print("updateLikePost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getPost(context: context, idPost: idPost);
        ScopedModel.of<ProfileModel>(context).getAllPosts(context: context);
        ScopedModel.of<UserModel>(context).getMyPosts(context: context);
        load = false;
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
      idPost: idPost,
      body: body,
      release: DateTime.now().toString(),
      idAuthor: id,
      idEntitySave: null,
      typeComment: TypeComment.POST,
    );
    var url = Uri.parse(base + 'comments/post/comment');
    var response = await http.post(
      url,
      headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"},
      body: json.encode(commentDTO.toMap()),
    );
    // ignore: avoid_print
    print("addCommentPost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 201:
        controller.clear();
        getPost(context: context, idPost: idPost);
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

  removeCommentPost({
    required String idPost,
    required BuildContext context,
    required String idComment,
    required bool screenUser,
  }) async {
    load = true;
    notifyListeners();
    String id = await getId();
    CommentDTO commentDTO = CommentDTO(
      idComment: idComment,
      idAuthor: id,
      idPost: idPost,
      body: null,
      release: DateTime.now().toString(),
      typeComment: TypeComment.POST,
      idEntitySave: null,
    );
    var url = Uri.parse(base + 'comments/delete/comment');
    var response = await http.delete(
      url,
      headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"},
      body: json.encode(commentDTO.toMap()),
    );
    // ignore: avoid_print
    print("removeCommentPost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        getPost(context: context, idPost: idPost);
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

  updateLikeComment({required BuildContext context, required String idComment, required String idPost}) async {
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'comments/put/like/comment/$idComment/user/$id');
    var response = await http.put(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
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

  removePost({
    required BuildContext context,
    required String idPost,
    required bool screenUser,
    required BuildContext contextPage,
  }) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'posts/delete/post/$idPost/user/$id');
    var response = await http.delete(
      url,
      headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"},
    );
    // ignore: avoid_print
    print("removePostCommentScreen: " + response.statusCode.toString());

    switch (response.statusCode) {
      case 200:
        await ScopedModel.of<ProfileModel>(context).getAllPosts(context: context);
        if (screenUser) {
          await ScopedModel.of<UserModel>(contextPage).getMyPosts(context: context);
        }
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

  showDeletePostBottomSheet({
    required BuildContext contextCommentPage,
    required String idPost,
    required bool screenComment,
    required bool screenUser,
    required BuildContext contextPage,
  }) {
    showModalBottomSheet<dynamic>(

        //isScrollControlled: true,
        context: contextCommentPage,
        builder: (context) {
          return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
            return BottomSheet(
                backgroundColor: theme.background,
                onClosing: () {},
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          removePost(
                            context: contextCommentPage,
                            idPost: idPost,
                            screenUser: screenUser,
                            contextPage: contextPage,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.delete),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: theme.sizeText,
                                  letterSpacing: theme.letterSpacingText,
                                  color: theme.title,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      )
                    ],
                  );
                });
          });
        });
  }

  showDeleteCommentBottomSheet({required BuildContext contextCommentPage, required String idPost, required String idComment, required bool screenComment, required bool screenUser, required BuildContext contextPage}) {
    showModalBottomSheet<dynamic>(

        //isScrollControlled: true,
        context: contextCommentPage,
        builder: (context) {
          return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
            return BottomSheet(
                backgroundColor: theme.background,
                onClosing: () {},
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          removeCommentPost(
                            context: contextCommentPage,
                            idComment: idComment,
                            idPost: idPost,
                            screenUser: screenUser,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.delete),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: theme.sizeText,
                                  letterSpacing: theme.letterSpacingText,
                                  color: theme.title,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      )
                    ],
                  );
                });
          });
        });
  }
}
