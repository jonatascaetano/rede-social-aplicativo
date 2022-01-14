import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/enuns/type_entity_save.dart';

class EntitySaveMini {
  late String id;
  late String typeEntitySave;
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

  EntitySaveMini.fromMap({required Map map}) {
    id = map["id"];
    typeEntitySave = map["typeEntitySave"];
    category = map["category"];
    goal = map["goal"];
    rated = map["rated"];
    reviewed = map["reviewed"];
    user = UserMini.fromMap(map: map["user"]);
    entity = map["typeEntitySave"] == TypeEntitySave.ENTITY
        ? EntityMini.fromMap(map: map["entity"])
        : null;
    season = map["typeEntitySave"] == TypeEntitySave.SEASON
        ? SeasonMini.fromMap(map: map["season"])
        : null;
    episode = map["typeEntitySave"] == TypeEntitySave.EPISODE
        ? EpisodeMini.fromMap(map: map["episode"])
        : null;
    evaluation = map["evaluation"];
    review = map["review"];
    typeObject = map["typeObject"];
    historic = map["historic"];
  }
}
