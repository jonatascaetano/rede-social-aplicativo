import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:social_network_application/entities/mini_dto/group_mini.dart';

class GroupModel extends Model {
  GroupModel({required String idGroup, required BuildContext contextPageGroup}) {
    // ignore: prefer_initializing_formals
    this.idGroup = idGroup;
    getGroup(idGroup: idGroup, contextPageGroup: contextPageGroup);
    getAllPosts(context: contextPageGroup);
  }

  static const String base = "https://jonatas-social-network-api.herokuapp.com/";

  bool groupIsNull = true;
  bool load = true;
  late GroupMini groupMini;
  late String idGroup;
  List<dynamic> posts = [];

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  getGroup({required String idGroup, required BuildContext contextPageGroup}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'groups/$idGroup/$id');
    var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
    // ignore: avoid_print
    print('getGroup: ' + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        var item = json.decode(response.body);
        // ignore: avoid_print
        groupMini = GroupMini.fromMap(map: item);
        load = false;
        groupIsNull = false;
        notifyListeners();
        break;
      default:
        load = false;
        groupIsNull = true;
        notifyListeners();
        ScaffoldMessenger.of(contextPageGroup).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }

  getAllPosts({required BuildContext context}) async {
    load = true;
    notifyListeners();
    String id = await getId();
    var url = Uri.parse(base + 'groups/group/$idGroup/user/$id/posts');
    var response = await http.get(url, headers: {"Accept": "application/json; charset=utf-8", "content-type": "application/json; charset=utf-8"});
    // ignore: avoid_print
    print("getAllPosts: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        posts = [];
        var itens = json.decode(response.body);
        posts = itens;
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
}
