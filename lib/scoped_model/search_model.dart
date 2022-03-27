import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/entities/mini_dto/group_mini.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/enuns/type_object.dart';
import 'package:social_network_application/widgets/mini_results/entity_mini_result.dart';
import 'package:social_network_application/widgets/mini_results/episode_mini_result.dart';
import 'package:social_network_application/widgets/mini_results/group_mini_result.dart';
import 'package:social_network_application/widgets/mini_results/season_mini_result.dart';
import 'package:social_network_application/widgets/mini_results/user_mini_result.dart';
import 'package:http/http.dart' as http;

class SearchModel extends Model {
  static const String base = "https://jonatas-social-network-api.herokuapp.com/";

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  Future<Set<String>>? getByNameSuggestions({required String text}) async {
    Set<String>? found = {};
    try {
      var url = Uri.parse(base + 'users/get/users/name?name=$text');
      var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
      // ignore: avoid_print
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (var object in list) {
            found.add(object["name"]!);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    try {
      var url = Uri.parse(base + 'entities/get/entities/name?name=$text');
      var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (var object in list) {
            found.add(object["name"]!);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    try {
      var url = Uri.parse(base + 'seasons/get/seasons/name?name=$text');
      var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (var object in list) {
            found.add(object["name"]!);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    try {
      var url = Uri.parse(base + 'episodes/get/episodes/name?name=$text');
      var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (var object in list) {
            found.add(object["name"]!);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    try {
      var url = Uri.parse(base + 'groups/name?name=$text');
      var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (var object in list) {
            found.add(object["name"]!);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return found;
  }

  Future<List<Map>> getByNameResult({required String text}) async {
    String id = await getId();
    List<Map>? found = [];
    try {
      var url = Uri.parse(base + 'users/get/users/name?name=$text');
      var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
      // ignore: avoid_print
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (var map in list) {
            if (map['id'] != id) {
              found.add(map);
            }
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    try {
      var url = Uri.parse(base + 'entities/get/entities/name?name=$text');
      var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (Map map in list) {
            found.add(map);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    try {
      var url = Uri.parse(base + 'seasons/get/seasons/name?name=$text');
      var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (Map map in list) {
            found.add(map);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    try {
      var url = Uri.parse(base + 'episodes/get/episodes/name?name=$text');
      var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (Map map in list) {
            found.add(map);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    try {
      var url = Uri.parse(base + 'groups/name?name=$text');
      var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
      // ignore: avoid_print
      switch (response.statusCode) {
        case 200:
          List<dynamic> list = json.decode(response.body);
          for (Map map in list) {
            found.add(map);
          }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    // ignore: avoid_print
    return found;
  }

  Widget goToViewMiniResult({required Map map}) {
    switch (map['typeObject']) {
      case TypeObject.USER:
        UserMini userMini = UserMini.fromMap(map: map);
        return UserMiniResult(userMini: userMini);
      case TypeObject.ENTITY:
        EntityMini entityMini = EntityMini.fromMap(map: map);
        return EntityMiniResult(entityMini: entityMini);
      case TypeObject.SEASON:
        SeasonMini seasonMini = SeasonMini.fromMap(map: map);
        return SeasonMiniResult(seasonMini: seasonMini);
      case TypeObject.EPISODE:
        EpisodeMini episodeMini = EpisodeMini.fromMap(map: map);
        return EpisodeMiniResult(episodeMini: episodeMini);
      case TypeObject.GROUP:
        GroupMini groupMini = GroupMini.fromMap(map: map);
        return GroupMiniResult(groupMini: groupMini);
      default:
        return Container();
    }
  }
}
