import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class PostTalkMini {
  late String? id;
  late String? release;
  late String? body;
  late String typePost;
  late String? typePostVisibility;
  late int likeQuantity = 0;
  late int commentQuantity = 0;
  late String typeObject;
  late bool spoiler;
  late UserMini? author;
  late bool liked;
  late UserMini? like;

  PostTalkMini.fromMap({required Map map}) {
    id = map["id"];
    release = DateTime.now().toString();
    body = map["body"];
    typePost = map["typePost"];
    typePostVisibility = map["typePostVisibility"];
    likeQuantity = map["likeQuantity"];
    commentQuantity = map["commentQuantity"];
    typeObject = map["typeObject"];
    spoiler = map["spoiler"] ?? false;
    author = map["author"] != null ? UserMini.fromMap(map: map["author"]) : null;
    liked = map["liked"] ?? false;
    like = map["like"] != null ? UserMini.fromMap(map: map["like"]) : null;
  }
}
