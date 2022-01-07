import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class EditionMini {
  late String id;
  late UserMini? user;
  late EntityMini? entity;
  late SeasonMini? season;
  late EpisodeMini? episode;
  late String? attribute;
  late Object? previus;
  late Object? current;
  late DateTime? release;

  EditionMini.fromMap({required Map map}) {
    id = map["id"];
    user = map["user"];
    entity = map["entity"];
    season = map["season"];
    episode = map["episode"];
    attribute = map["attribute"];
    previus = map["previus"];
    current = map["current"];
    release = map["release"];
  }
}
