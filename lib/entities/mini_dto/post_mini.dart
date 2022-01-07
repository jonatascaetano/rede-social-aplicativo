import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class PostMini {
  late String? id;
  late int? type;
  late DateTime? release;
  late String? body;
  late int? category;
  late UserMini? user;
  late EntityMini? entity;
  late SeasonMini? season;
  late EpisodeMini? episode;
  late int? comments;
  late int? likes;

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
