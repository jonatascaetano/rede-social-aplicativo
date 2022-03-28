/*

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/dto/season_dto.dart';
import 'package:http/http.dart' as http;
import 'entity_model.dart';

class NewSeasonModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  bool load = false;

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  createSeason(
      {required SeasonDTO seasonDTO,
      required String idEntity,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    String idUser = await getId();
    var url = Uri.parse(base + 'seasons/post/entity/$idEntity/user/$idUser');
    var response = await http.post(
      url,
      headers: {
        "Accept": "application/json; charset=utf-8",
        "content-type": "application/json; charset=utf-8"
      },
      body: json.encode(seasonDTO.toMap()),
    );
    // ignore: avoid_print
    print('createSeason: ' + response.statusCode.toString());
    switch (response.statusCode) {
      case 201:
        ScopedModel.of<EntityModel>(context).getSeasons(entityId: idEntity);
        load = false;
        notifyListeners();
        Navigator.pop(context);
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        load = false;
        notifyListeners();
    }
  }
}

*/