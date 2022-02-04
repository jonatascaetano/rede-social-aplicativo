import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/converts/convert_to_enum.dart';
import 'package:social_network_application/entities/dto/entity_save_dto.dart';
import 'package:social_network_application/entities/dto/post_update_dto.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/entities/mini_dto/post_update_mini.dart';
import 'package:social_network_application/entities/mini_dto/worker_mini.dart';
import 'package:http/http.dart' as http;
import 'package:social_network_application/enuns/level.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/view/episode/add_body_post_episode.dart';

class EpisodeModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  bool load = false;
  bool episodeMiniIsNull = true;
  late EpisodeMini episodeMini;
  late EntitySaveMini? entitySaveMini;
  late List<WorkerMini> workers = [];
  int maxLine = 5;
  List<DropdownMenuItem<int>> dropdownList = [];
  late String idUser;

  updateMaxLine() {
    if (maxLine == 5) {
      maxLine = 500;
      notifyListeners();
    } else {
      maxLine = 5;
      notifyListeners();
    }
  }

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    idUser = prefs.getString("id")!;
    notifyListeners();
    return prefs.getString("id")!;
  }

  getEpisode({required String episodeId}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'episodes/get/episode/$episodeId');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print('getEntityById: ' + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var item = json.decode(response.body);
        // ignore: avoid_print
        print(item);
        episodeMini = EpisodeMini.fromMap(map: item);
        loadDropdownList();
        load = false;
        episodeMiniIsNull = false;
        notifyListeners();
    }
  }

  getEntitySave({required String episodeId}) async {
    load = true;
    notifyListeners();
    String idUser = await getId();
    var url = Uri.parse(
        base + 'episodes/get/episode/$episodeId/entitysave/user/$idUser');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
// ignore: avoid_print
    print("getEntitySave: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var item = json.decode(response.body);
        // ignore: avoid_print
        print(item.toString());
        entitySaveMini = EntitySaveMini.fromMap(map: item);
        load = false;
        notifyListeners();
        break;
    }
  }

  loadDropdownList() {
    dropdownList = [];
    dropdownList.add(DropdownMenuItem(
      child: Text(LanguageModel().entitiesCategories[
          ConvertToEnum.convertTypeEntityToValue(
              typeEntity: episodeMini.season.entity.typeEntity)][1]),
      value: 1,
    ));
    // dropdownList.add(DropdownMenuItem(
    //   child: Text(LanguageModel().entitiesCategories[
    //       ConvertToEnum.convertTypeEntityToValue(
    //           typeEntity: entityMini.typeEntity)][2]),
    //   value: 2,
    // ));
    // dropdownList.add(DropdownMenuItem(
    //   child: Text(LanguageModel().entitiesCategories[
    //       ConvertToEnum.convertTypeEntityToValue(
    //           typeEntity: entityMini.typeEntity)][3]),
    //   value: 3,
    // ));
    // dropdownList.add(DropdownMenuItem(
    //   child: Text(LanguageModel().entitiesCategories[
    //       ConvertToEnum.convertTypeEntityToValue(
    //           typeEntity: entityMini.typeEntity)][4]),
    //   value: 4,
    // ));
    notifyListeners();
  }

  newEntitySave(
      {required EntitySaveDTO entitySaveDTO,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'entitysaves/post/episode');
    var response = await http
        .post(url, body: json.encode(entitySaveDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
// ignore: avoid_print
    print("newEntitySave: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 201:
        var item = json.decode(response.body);
        // ignore: avoid_print
        print(item.toString());
        entitySaveMini = EntitySaveMini.fromMap(map: item);
        newPost(
            entitySaveMini: entitySaveMini!,
            category: entitySaveMini!.category!,
            context: context);
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

  updateCategoryEntitySave(
      {required EntitySaveDTO entitySaveDTO,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'entitysaves/put/category');
    var response =
        await http.put(url, body: json.encode(entitySaveDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
// ignore: avoid_print
    print("updateCategoryEntitySave: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        var item = json.decode(response.body);
        // ignore: avoid_print
        print(item.toString());
        entitySaveMini = EntitySaveMini.fromMap(map: item);
        newPost(
            entitySaveMini: entitySaveMini!,
            category: entitySaveMini!.category!,
            context: context);
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

  updateEvaluationEntitySave(
      {required EntitySaveDTO entitySaveDTO,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'entitysaves/put/evaluation');
    var response =
        await http.put(url, body: json.encode(entitySaveDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
// ignore: avoid_print
    print("updateEvaluationEntitySave: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        var item = json.decode(response.body);
        // ignore: avoid_print
        print(item.toString());
        entitySaveMini = EntitySaveMini.fromMap(map: item);
        getEpisode(episodeId: entitySaveMini!.episode!.id);
        newPost(entitySaveMini: entitySaveMini!, category: 6, context: context);
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

//   updateGoalEntitySave(
//       {required EntitySaveDTO entitySaveDTO,
//       required BuildContext context}) async {
//     load = true;
//     notifyListeners();
//     var url = Uri.parse(base + 'entitysaves/put/goal');
//     var response =
//         await http.put(url, body: json.encode(entitySaveDTO.toMap()), headers: {
//       "Accept": "application/json; charset=utf-8",
//       "content-type": "application/json; charset=utf-8"
//     });
// // ignore: avoid_print
//     print("updateGoalEntitySave: " + response.statusCode.toString());
//     switch (response.statusCode) {
//       case 202:
//         var item = json.decode(response.body);
//         // ignore: avoid_print
//         print(item.toString());
//         entitySaveMini = EntitySaveMini.fromMap(map: item);
//         load = false;
//         notifyListeners();
//         break;
//       default:
//         load = false;
//         notifyListeners();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Try again later')),
//         );
//         break;
//     }
//   }

  updateReviewEntitySave(
      {required EntitySaveDTO entitySaveDTO,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'entitysaves/put/review');
    var response =
        await http.put(url, body: json.encode(entitySaveDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
// ignore: avoid_print
    print("updateReviewEntitySave: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        var item = json.decode(response.body);
        // ignore: avoid_print
        print(item.toString());
        entitySaveMini = EntitySaveMini.fromMap(map: item);
        newPost(entitySaveMini: entitySaveMini!, category: 7, context: context);
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

  newPost(
      {required EntitySaveMini entitySaveMini,
      required int category,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    PostUpdateDTO postUpdateDTO = PostUpdateDTO(
      idPost: null,
      level: entitySaveMini.level,
      release: DateTime.now().toString(),
      body: category == 7 ? entitySaveMini.review : null,
      category: category,
      idUser: idUser,
      idEntity: entitySaveMini.level == Level.ENTITY
          ? entitySaveMini.entity!.id
          : null,
      idSeason: entitySaveMini.level == Level.SEASON
          ? entitySaveMini.season!.id
          : null,
      idEpisode: entitySaveMini.level == Level.EPISODE
          ? entitySaveMini.episode!.id
          : null,
      evaluation: category == 6 ? entitySaveMini.evaluation! : 0,
      spoiler: category == 7 ? entitySaveMini.spoiler : false,
    );
    // ignore: avoid_print
    print("postUpdateDTO: " + postUpdateDTO.toMap().toString());
    var url = Uri.parse(base + 'posts/post/update');
    var response = await http
        .post(url, body: json.encode(postUpdateDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
// ignore: avoid_print
    print("newPost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 201:
        var item = json.decode(response.body);
        // ignore: avoid_print
        print(item.toString());
        PostUpdateMini postUpdateMini = PostUpdateMini.fromMap(map: item);
        if (postUpdateMini.category != 7) {
          load = false;
          notifyListeners();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddBodyPostEpisode(postUpdateMini: postUpdateMini)));
          ScopedModel.of<ProfileModel>(context).getAllPosts(context: context);
        } else {
          ScopedModel.of<ProfileModel>(context).getAllPosts(context: context);
          load = false;
          notifyListeners();
          Navigator.pop(context);
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

  addBodyPost(
      {required PostUpdateDTO postUpdateDTO,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'posts/put/body');
    var response =
        await http.put(url, body: json.encode(postUpdateDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
// ignore: avoid_print
    print("addBodyPost: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        load = false;
        notifyListeners();
        Navigator.pop(context);
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
}
