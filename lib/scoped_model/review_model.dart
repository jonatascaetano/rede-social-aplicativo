import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';

class ReviewModel extends Model {
  String idReview;
  BuildContext contextAncestor;
  bool entitySaveMiniIsNull = true;
  bool load = true;
  EntitySaveMini? entitySaveMini;

  ReviewModel({required this.idReview, required this.contextAncestor}) {
    getReview();
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
    var url = Uri.parse(base + 'entitysaves/get/entitysave/$idReview');
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
}
