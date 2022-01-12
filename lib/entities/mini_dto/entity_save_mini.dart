import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class EntitySaveMini {
  late String? id;
  late int? type;
  late int? categoty;
  late bool? goal;
  late bool? rated;
  late bool? review;
  late UserMini? user;
  late EntityMini? entity;
  late SeasonMini? season;
  late EpisodeMini? episode;
  late int? evaluation;
  late List<DateTime>? historic;

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
