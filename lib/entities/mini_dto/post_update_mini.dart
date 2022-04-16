import 'package:social_network_application/entities/mini_dto/entity_micro.dart';
import 'package:social_network_application/entities/mini_dto/user_micro_widget.dart';

class PostUpdateMini {
  late String? id;
  late String? release;
  late String? body;
  late int category;
  late UserMicroWidget author;
  late EntityMicro? entity;
  late int likeQuantity = 0;
  late int commentQuantity = 0;
  late String typeObject;
  late String typePostVisibility;
  late String level;
  late String typePost;
  late bool spoiler;
  late int evaluation;
  late bool liked;
  late UserMicroWidget? like;

  PostUpdateMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    body = map["body"];
    category = map["category"];
    author = UserMicroWidget.fromMap(map: map["author"]);
    entity = map["entity"] != null ? EntityMicro.fromMap(map: map["entity"]) : null;
    likeQuantity = map["likeQuantity"];
    commentQuantity = map["commentQuantity"];
    typeObject = map["typeObject"];
    typePostVisibility = map["typePostVisibility"];
    level = map["level"];
    typePost = map["typePost"];
    spoiler = map["spoiler"] ?? false;
    evaluation = map["evaluation"] ?? 0;
    liked = map["liked"] ?? false;
    like = map["like"] != null ? UserMicroWidget.fromMap(map: map["like"]) : null;
  }
}
