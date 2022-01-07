import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class EvaluationMini {
  late String? id;
  late int? type;
  late double? value;
  late DateTime? release;
  late UserMini? user;
  late EntityMini? entity;
  late SeasonMini? season;
  late EpisodeMini? episode;

  EvaluationMini.fromMap({required Map map}) {
    id = map["id"];
    type = map["type"];
    value = map["value"];
    release = map["release"];
    user = map["user"];
    entity = map["entity"];
    season = map["season"];
    episode = map["episode"];
  }
}
