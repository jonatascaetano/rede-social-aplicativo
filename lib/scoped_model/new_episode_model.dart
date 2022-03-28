/*

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_network_application/entities/dto/episode_dto.dart';
import 'package:http/http.dart' as http;
import 'package:social_network_application/scoped_model/season_model.dart';

class NewEpisodeModel extends Model {
  static const String base =
      "https://jonatas-social-network-api.herokuapp.com/";

  bool load = false;

  Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("id")!;
  }

  createEpisode(
      {required EpisodeDTO episodeDTO,
      required String idSeason,
      required BuildContext context}) async {
    load = true;
    notifyListeners();
    String idUser = await getId();
    var url = Uri.parse(base + 'episodes/post/season/$idSeason/user/$idUser');
    var response = await http.post(
      url,
      headers: {
        "Accept": "application/json; charset=utf-8",
        "content-type": "application/json; charset=utf-8"
      },
      body: json.encode(episodeDTO.toMap()),
    );
    // ignore: avoid_print
    print('createSeason: ' + response.statusCode.toString());
    switch (response.statusCode) {
      case 201:
        ScopedModel.of<SeasonModel>(context).getEpisodes(seasonId: idSeason);
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