import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/dto/group_dto.dart';
import 'package:social_network_application/entities/mini_dto/group_mini.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/view/objects/group.dart';

class NewGroupModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  bool load = false;
  late GroupMini groupMini;

  newGroup({
    required GroupDTO groupDTO,
    required BuildContext contextNewGroup,
  }) async {
    load = true;
    notifyListeners();
    var url = Uri.parse(base + 'groups');
    var response = await http.post(
      url,
      headers: {
        "Accept": "application/json; charset=utf-8",
        "content-type": "application/json; charset=utf-8"
      },
      body: json.encode(groupDTO.toMap()),
    );
    // ignore: avoid_print
    print("newGroup: " + response.statusCode.toString());
    switch (response.statusCode) {
      case 201:
        var map = json.decode(response.body);
        groupMini = GroupMini.fromMap(map: map);
        await ScopedModel.of<ProfileModel>(contextNewGroup)
            .getGroups(context: contextNewGroup);
        load = false;
        notifyListeners();
        Navigator.pushReplacement(
            contextNewGroup,
            MaterialPageRoute(
                builder: (contextNewGroup) => Group(groupMini: groupMini)));
        break;
      default:
        load = false;
        notifyListeners();
        ScaffoldMessenger.of(contextNewGroup).showSnackBar(
          const SnackBar(content: Text('Try again later')),
        );
        break;
    }
  }
}
