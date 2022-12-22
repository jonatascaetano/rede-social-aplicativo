import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/dto/entity_dto.dart';
import 'package:http/http.dart' as http;
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/view/objects/entity2.dart';

class NewEntityModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  bool load = false;

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  createEntity(
      {required EntityDTO entityDTO, required BuildContext context}) async {
    load = true;
    notifyListeners();
    String idUser = await getId();
    var url = Uri.parse(base + 'entities/post/entity/user/$idUser');
    var response = await http.post(
      url,
      headers: {
        "Accept": "application/json; charset=utf-8",
        "content-type": "application/json; charset=utf-8"
      },
      body: json.encode(entityDTO.toMap()),
    );
    // ignore: avoid_print
    print('createEntity: ' + response.statusCode.toString());
    switch (response.statusCode) {
      case 201:
        load = false;
        notifyListeners();
        var map = json.decode(response.body);
        EntityMini entityMini = EntityMini.fromMap(map: map);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Entity2(entityMini: entityMini, datasheetIsOpen: false)));
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
