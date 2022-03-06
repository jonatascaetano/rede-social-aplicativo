import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/dto/comment_dto.dart';
import 'package:social_network_application/entities/mini_dto/comment_mini.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';
import 'package:social_network_application/enuns/type_comment.dart';
import 'package:social_network_application/enuns/type_object.dart';
import 'package:social_network_application/scoped_model/entity_model.dart';
import 'package:social_network_application/scoped_model/season_model.dart';

import 'episode_model.dart';
import 'support/theme_model.dart';

class ReviewModel extends Model {
  String idReview;
  BuildContext contextAncestor;
  bool entitySaveMiniIsNull = true;
  bool load = true;
  EntitySaveMini? entitySaveMini;
  List<CommentMini> comments = [];
  TextEditingController controller = TextEditingController();
  late String typeObject;

  ReviewModel(
      {required this.idReview,
      required this.contextAncestor,
      required this.typeObject}) {
    getReview();
    getAllCommentReview(idReview: idReview, context: contextAncestor);
  }

  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  getReview() async {
    load = true;
    notifyListeners();
    String idUser = await getId();
    var url =
        Uri.parse(base + 'entitysaves/get/entitysave/$idReview/user/$idUser');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
// ignore: avoid_print
    print("getReview: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var item = json.decode(response.body);
        // ignore: avoid_print
        print(item.toString());
        entitySaveMini = EntitySaveMini.fromMap(map: item);
        entitySaveMiniIsNull = false;
        load = false;
        notifyListeners();
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(contextAncestor).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  updateLikeReview(
      {required BuildContext context, required String idReview}) async {
    load = true;
    notifyListeners();
    String idUser = await getId();
    var url = Uri.parse(
        base + 'entitysaves/put/like/entitysave/$idReview/user/$idUser');
    var response = await http.put(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("updateLikePost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        getReview();
        switch (typeObject) {
          case TypeObject.ENTITY:
            ScopedModel.of<EntityModel>(context)
                .getReviews(entityId: entitySaveMini!.entity!.id);
            break;
          case TypeObject.SEASON:
            ScopedModel.of<SeasonModel>(context)
                .getReviews(seasonId: entitySaveMini!.season!.id);
            break;
          case TypeObject.EPISODE:
            ScopedModel.of<EpisodeModel>(context)
                .getReviews(episodeId: entitySaveMini!.episode!.id);
            break;
          default:
        }
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

  getAllCommentReview(
      {required String idReview, required BuildContext context}) async {
    load = true;
    notifyListeners();
    String idUser = await getId();
    var url =
        Uri.parse(base + 'entitysaves/get/comments/$idReview/user/$idUser');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("getAllCommentReview: " + response.statusCode.toString());
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

  addCommentPost({
    required String idEntitySave,
    required BuildContext context,
    required String body,
  }) async {
    load = true;
    notifyListeners();
    String id = await getId();
    CommentDTO commentDTO = CommentDTO(
      idComment: null,
      idPost: null,
      body: body,
      release: DateTime.now().toString(),
      idAuthor: id,
      idEntitySave: idEntitySave,
      typeComment: TypeComment.ENTITY_SAVE,
    );
    var url = Uri.parse(base + 'comments/post/comment/entitysave');
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
        getReview();
        getAllCommentReview(idReview: idReview, context: context);
        switch (typeObject) {
          case TypeObject.ENTITY:
            ScopedModel.of<EntityModel>(context)
                .getReviews(entityId: entitySaveMini!.entity!.id);
            break;
          case TypeObject.SEASON:
            ScopedModel.of<SeasonModel>(context)
                .getReviews(seasonId: entitySaveMini!.season!.id);
            break;
          case TypeObject.EPISODE:
            ScopedModel.of<EpisodeModel>(context)
                .getReviews(episodeId: entitySaveMini!.episode!.id);
            break;
          default:
        }
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

  removeCommentReview({
    required String idReview,
    required BuildContext context,
    required String idComment,
  }) async {
    load = true;
    notifyListeners();
    String id = await getId();
    CommentDTO commentDTO = CommentDTO(
      idComment: idComment,
      idAuthor: id,
      idPost: null,
      body: null,
      release: DateTime.now().toString(),
      typeComment: TypeComment.POST,
      idEntitySave: idReview,
    );
    var url = Uri.parse(base + 'comments/delete/comment/entitysave');
    var response = await http.delete(
      url,
      headers: {
        "Accept": "application/json; charset=utf-8",
        "content-type": "application/json; charset=utf-8"
      },
      body: json.encode(commentDTO.toMap()),
    );
    // ignore: avoid_print
    print("removeCommentReview: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        getReview();
        getAllCommentReview(idReview: idReview, context: context);
        switch (typeObject) {
          case TypeObject.ENTITY:
            ScopedModel.of<EntityModel>(context)
                .getReviews(entityId: entitySaveMini!.entity!.id);
            break;
          case TypeObject.SEASON:
            ScopedModel.of<SeasonModel>(context)
                .getReviews(seasonId: entitySaveMini!.season!.id);
            break;
          case TypeObject.EPISODE:
            ScopedModel.of<EpisodeModel>(context)
                .getReviews(episodeId: entitySaveMini!.episode!.id);
            break;
          default:
        }
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
      required String idReview}) async {
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
        getAllCommentReview(idReview: idReview, context: context);
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

  showDeleteCommentBottomSheet(
      {required BuildContext contextCommentPage,
      required String idReview,
      required String idComment,
      required BuildContext contextPage}) {
    showModalBottomSheet<dynamic>(

        //isScrollControlled: true,
        context: contextCommentPage,
        builder: (context) {
          return ScopedModelDescendant<ThemeModel>(
              builder: (context, child, theme) {
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
                          removeCommentReview(
                            idReview: idReview,
                            context: contextCommentPage,
                            idComment: idComment,
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
