import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/enuns/level.dart';

class EntitySaveMini {
  late String id;
  late String level;
  late int? category;
  late bool goal;
  late bool rated;
  late bool reviewed;
  late UserMini? user;
  late EntityMini? entity;
  late SeasonMini? season;
  late EpisodeMini? episode;
  late int? evaluation;
  late String? review;
  late String typeObject;
  late List<dynamic>? historic = [];
  late bool spoiler;
  late String? release;

  EntitySaveMini.fromMap({required Map map}) {
    id = map["id"];
    level = map["level"];
    category = map["category"];
    goal = map["goal"];
    rated = map["rated"];
    reviewed = map["reviewed"];
    user = UserMini.fromMap(map: map["user"]);
    entity = map["level"] == Level.ENTITY
        ? EntityMini.fromMap(map: map["entity"])
        : null;
    season = map["level"] == Level.SEASON
        ? SeasonMini.fromMap(map: map["season"])
        : null;
    episode = map["level"] == Level.EPISODE
        ? EpisodeMini.fromMap(map: map["episode"])
        : null;
    evaluation = map["evaluation"];
    review = map["review"];
    typeObject = map["typeObject"];
    historic = map["historic"];
    spoiler = map["spoiler"];
    release = map["release"];
  }
}
