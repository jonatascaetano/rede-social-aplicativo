import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';

class DatasheetModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  bool load = false;
  bool entitySaveMinisIsNull = true;
  List<EntitySaveMini> entitySaveMinis = [];

  DatasheetModel(
      {required BuildContext context,
      required String typeEntity,
      required String idUser}) {
    getEntitiesSave(context: context, typeEntity: typeEntity, idUser: idUser);
  }

  getEntitiesSave(
      {required BuildContext context,
      required String typeEntity,
      required String idUser}) async {
    load = true;
    notifyListeners();
    // ignore: avoid_print
    print('******** ' + typeEntity);
    var url =
        Uri.parse(base + 'users/get/user/$idUser/entitySaves/$typeEntity');
    var response = await http.get(url, headers: {
      "Accept": "application/json; charset=utf-8",
      "content-type": "application/json; charset=utf-8"
    });
    // ignore: avoid_print
    print("getEntitiesSave: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        entitySaveMinis = [];
        var itens = json.decode(response.body);
        for (var item in itens) {
          EntitySaveMini entitySaveMini =
              EntitySaveMini.fromMap(map: item as Map);
          entitySaveMinis.add(entitySaveMini);
        }
        entitySaveMinisIsNull = false;
        load = false;
        notifyListeners();
        break;
      default:
        load = false;
        notifyListeners();
    }
  }
}
