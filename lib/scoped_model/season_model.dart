import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/converts_enum/convert_to_enum.dart';
import 'package:social_network_application/entities/dto/entity_save_dto.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';
import 'package:social_network_application/entities/mini_dto/worker_mini.dart';
import 'package:http/http.dart' as http;
import 'package:social_network_application/scoped_model/support/language_model.dart';

class SeasonModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  bool load = false;
  bool seasonMiniIsNull = true;
  late SeasonMini seasonMini;
  late EntitySaveMini? entitySaveMini;
  late List<EpisodeMini> episodes = [];
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

  getSeason({required String seasonId}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'seasons/get/season/$seasonId');
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
        seasonMini = SeasonMini.fromMap(map: item);
        loadDropdownList();
        load = false;
        seasonMiniIsNull = false;
        notifyListeners();
    }
  }

  getEntitySave({required String seasonId}) async {
    load = true;
    notifyListeners();
    String idUser = await getId();
    var url = Uri.parse(
        base + 'seasons/get/season/$seasonId/entitysave/user/$idUser');
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

  getEpisodes({required String seasonId}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'seasons/get/episodes/$seasonId');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
// ignore: avoid_print
    print("getSeason: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        episodes = [];
        var itens = json.decode(response.body);
        for (var item in itens) {
          EpisodeMini episodeMini = EpisodeMini.fromMap(map: item as Map);
          episodes.add(episodeMini);
          notifyListeners();
        }
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
              typeEntity: seasonMini.entity.typeEntity)][1]),
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
    var url = Uri.parse(base + 'entitysaves/post/season');
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
        load = false;
        notifyListeners();
        getSeason(seasonId: seasonMini.id);
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
