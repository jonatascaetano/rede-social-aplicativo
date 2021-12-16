import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class PostMini {
  late String id;
  late int type;
  late DateTime release;
  late String body;
  late int category;
  late UserMini user;
  late EntityMini entity;
  late SeasonMini season;
  late EpisodeMini episode;
  late int comments;
  late int likes;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["type"] = type;
    map["release"] = release;
    map["body"] = body;
    map["category"] = category;
    map["user"] = user;
    map["entity"] = entity;
    map["season"] = season;
    map["episode"] = episode;
    map["comments"] = comments;
    map["likes"] = likes;
    return map;
  }

  PostMini.fromMap({required Map map}) {
    id = map["id"];
    type = map["type"];
    release = map["release"];
    body = map["body"];
    category = map["category"];
    user = map["user"];
    entity = map["entity"];
    season = map["season"];
    episode = map["episode"];
    comments = map["comments"];
    likes = map["likes"];
  }
}
