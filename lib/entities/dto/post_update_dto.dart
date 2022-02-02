import 'package:social_network_application/enuns/type_post.dart';
import 'package:social_network_application/enuns/type_post_visibility.dart';

class PostUpdateDTO {
  late String? idPost;
  late String typePost = TypePost.UPDATE;
  late String? level;
  late String typePostVisibility = TypePostVisibility.USER;
  late String? release;
  late String? body;
  late int category;
  late String idUser;
  late String? idEntity;
  late String? idSeason;
  late String? idEpisode;
  late int evaluation;
  late bool spoiler;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idPost"] = idPost;
    map["typePost"] = typePost;
    map["level"] = level;
    map["typePostVisibility"] = typePostVisibility;
    map["release"] = release;
    map["body"] = body;
    map["category"] = category;
    map["idUser"] = idUser;
    map["idEntity"] = idEntity;
    map["idSeason"] = idSeason;
    map["idEpisode"] = idEpisode;
    map["evaluation"] = evaluation;
    map["spoiler"] = spoiler;
    return map;
  }

  PostUpdateDTO({
    required this.idPost,
    //required this.typePost,
    required this.level,
    //required this.typePostVisibility,
    required this.release,
    required this.body,
    required this.category,
    required this.idUser,
    required this.idEntity,
    required this.idSeason,
    required this.idEpisode,
    required this.evaluation,
    required this.spoiler,
  });
}
