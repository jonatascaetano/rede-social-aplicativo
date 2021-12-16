import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/entities/mini_dto/evaluation_mini.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class EntitySaveMini {
  late String id;
  late int type;
  late int categoty;
  late bool goal;
  late bool rated;
  late bool review;
  late UserMini user;
  late EntityMini entity;
  late SeasonMini season;
  late EpisodeMini episode;
  late EvaluationMini evaluation;
  late List<DateTime> historic;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["type"] = type;
    map["categoty"] = categoty;
    map["goal"] = goal;
    map["rated"] = rated;
    map["review"] = review;
    map["user"] = user;
    map["entity"] = entity;
    map["season"] = season;
    map["episode"] = episode;
    map["evaluation"] = evaluation;
    map["historic"] = historic;
    return map;
  }

  EntitySaveMini.fromMap({required Map map}) {
    id = map["id"];
    type = map["type"];
    categoty = map["categoty"];
    goal = map["goal"];
    rated = map["rated"];
    review = map["review"];
    user = map["user"];
    entity = map["entity"];
    season = map["season"];
    episode = map["episode"];
    evaluation = map["evaluation"];
    historic = map["historic"];
  }
}
