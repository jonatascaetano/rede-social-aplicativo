import 'package:social_network_application/entities/mini_dto/entity_micro.dart';
import 'package:social_network_application/entities/mini_dto/user_micro_widget.dart';

class EntitySaveMini {
  late String id;
  late String level;
  late int? category;
  late bool goal;
  late bool rated;
  late bool reviewed;
  late UserMicroWidget user;
  late EntityMicro entity;
  late int? evaluation;
  late String? review;
  late String typeObject;
  late bool spoiler;
  late String? release;
  late int likeQuantity = 0;
  late int commentQuantity = 0;
  late bool liked;
  late UserMicroWidget? like;

  EntitySaveMini.fromMap({required Map map}) {
    id = map["id"];
    level = map["level"];
    category = map["category"];
    goal = map["goal"];
    rated = map["rated"];
    reviewed = map["reviewed"];
    user = UserMicroWidget.fromMap(map: map["user"]);
    entity = EntityMicro.fromMap(map: map["entity"]);
    evaluation = map["evaluation"];
    review = map["review"];
    typeObject = map["typeObject"];
    spoiler = map["spoiler"];
    release = map["release"];
    likeQuantity = map["likeQuantity"];
    commentQuantity = map["commentQuantity"];
    liked = map["liked"] ?? false;
    like = map["like"] != null ? UserMicroWidget.fromMap(map: map["like"]) : null;
  }
}
