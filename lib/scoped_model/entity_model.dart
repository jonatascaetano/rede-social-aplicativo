import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:social_network_application/converts/convert_to_enum.dart';
import 'package:social_network_application/entities/dto/entity_save_dto.dart';
import 'package:social_network_application/entities/dto/post_update_dto.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';
import 'package:social_network_application/entities/mini_dto/post_update_mini.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';
import 'package:social_network_application/entities/mini_dto/worker_mini.dart';
import 'package:social_network_application/enuns/level.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/view/objects/entity/add_body_post_entity.dart';
import 'package:social_network_application/view/objects/entity/new_season_entity.dart';

import 'support/theme_model.dart';

class EntityModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  bool load = false;
  late EntityMini entityMini;
  bool entityMiniIsNull = true;
  List<WorkerMini> workers = [];
  List<SeasonMini> seasons = [];
  late String idUser;
  EntitySaveMini? entitySaveMini;
  int maxLine = 5;
  List<DropdownMenuItem<int>> dropdownList = [];
  bool spoiler = false;
  List<EntitySaveMini> reviews = [];

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    idUser = prefs.getString("id")!;
    notifyListeners();
    return prefs.getString("id")!;
  }

  getEntity({required String entityId}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'entities/get/entity/$entityId');
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
        entityMini = EntityMini.fromMap(map: item);
        loadDropdownList();
        load = false;
        entityMiniIsNull = false;
        notifyListeners();
    }
  }

  getSeasons({required String entityId}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'entities/get/entity/$entityId/seasons');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
// ignore: avoid_print
    print("getSeasons: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        seasons = [];
        var itens = json.decode(response.body);
        for (var item in itens) {
          SeasonMini seasonMini = SeasonMini.fromMap(map: item as Map);
          seasons.add(seasonMini);
        }
        load = false;
        notifyListeners();
        break;
    }
  }

  getReviews({required String entityId}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'entities/get/reviews/$entityId');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
// ignore: avoid_print
    print("getReviews: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        reviews = [];
        var itens = json.decode(response.body);
        for (var item in itens) {
          EntitySaveMini entitySaveMini =
              EntitySaveMini.fromMap(map: item as Map);
          reviews.add(entitySaveMini);
        }
        load = false;
        notifyListeners();
        break;
    }
  }

  getEntitySave({required String entityId}) async {
    load = true;
    notifyListeners();
    String idUser = await getId();
    var url = Uri.parse(
        base + 'entities/get/entity/$entityId/entitysave/user/$idUser');
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

  getWorkers({required String entityId}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'entities/get/entity/$entityId/workers');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
// ignore: avoid_print
    print("getWorkersEntity: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        workers = [];
        var itens = json.decode(response.body);
        for (var item in itens) {
          WorkerMini workerMini = WorkerMini.fromMap(map: item as Map);
          workers.add(workerMini);
          notifyListeners();
        }
        load = false;
        notifyListeners();
        break;
    }
  }

  updateMaxLine() {
    if (maxLine == 5) {
      maxLine = 500;
      notifyListeners();
    } else {
      maxLine = 5;
      notifyListeners();
    }
  }

  updateSpoiler() {
    spoiler = !spoiler;
  }

  loadDropdownList() {
    dropdownList = [];
    dropdownList.add(DropdownMenuItem(
      child: Text(LanguageModel().entitiesCategories[
          ConvertToEnum.convertTypeEntityToValue(
              typeEntity: entityMini.typeEntity)][1]),
      value: 1,
    ));
    dropdownList.add(DropdownMenuItem(
      child: Text(LanguageModel().entitiesCategories[
          ConvertToEnum.convertTypeEntityToValue(
              typeEntity: entityMini.typeEntity)][2]),
      value: 2,
    ));
    dropdownList.add(DropdownMenuItem(
      child: Text(LanguageModel().entitiesCategories[
          ConvertToEnum.convertTypeEntityToValue(
              typeEntity: entityMini.typeEntity)][3]),
      value: 3,
    ));
    dropdownList.add(DropdownMenuItem(
      child: Text(LanguageModel().entitiesCategories[
          ConvertToEnum.convertTypeEntityToValue(
              typeEntity: entityMini.typeEntity)][4]),
      value: 4,
    ));
    notifyListeners();
  }

  newEntitySave(
      {required EntitySaveDTO entitySaveDTO,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'entitysaves/post/entity');
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
        getEntity(entityId: entitySaveMini!.entity!.id);
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
        getEntity(entityId: entitySaveMini!.entity!.id);
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
        getEntity(entityId: entitySaveMini!.entity!.id);
        newPost(entitySaveMini: entitySaveMini!, category: 6, context: context);
        getReviews(entityId: entitySaveMini!.entity!.id);
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

  updateGoalEntitySave(
      {required EntitySaveDTO entitySaveDTO,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'entitysaves/put/goal');
    var response =
        await http.put(url, body: json.encode(entitySaveDTO.toMap()), headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
// ignore: avoid_print
    print("updateGoalEntitySave: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 202:
        var item = json.decode(response.body);
        // ignore: avoid_print
        print(item.toString());
        entitySaveMini = EntitySaveMini.fromMap(map: item);
        load = false;
        notifyListeners();
        if (entitySaveMini!.goal) {
          newPost(
              entitySaveMini: entitySaveMini!, category: 5, context: context);
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

  updateReviewEntitySave(
      {required EntitySaveDTO entitySaveDTO,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    entitySaveDTO.release = DateTime.now().toString();
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
        getReviews(entityId: entitySaveMini!.entity!.id);
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
      idAuthor: idUser,
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
                      AddBodyPostEntity(postUpdateMini: postUpdateMini)));
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

  showOptionsEntityBottomSheet(
      {required BuildContext contextAncestor, required EntityMini entityMini}) {
    showModalBottomSheet<dynamic>(

        //isScrollControlled: true,
        context: contextAncestor,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewSeasonEntity(
                                  entityMini: entityMini,
                                  context: contextAncestor),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_box_rounded,
                                color: theme.emphasis,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                'New Season',
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
