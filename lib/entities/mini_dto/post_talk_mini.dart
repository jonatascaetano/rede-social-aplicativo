import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class PostTalkMini {
  late String? id;
  late String? release;
  late String? body;
  late int typePost;
  late String? typePostVisibility;
  late int likeQuantity = 0;
  late int commentQuantity = 0;
  late String typeObject;
  late bool spoiler;
  late UserMini? author;
  late bool liked;

  PostTalkMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    body = map["body"];
    typePost = map["typePost"];
    typePostVisibility = typePostVisibility;
    likeQuantity = map["likeQuantity"];
    commentQuantity = map["commentQuantity"];
    typeObject = map["typeObject"];
    spoiler = map["spoiler"] ?? false;
    author =
        map["author"] != null ? UserMini.fromMap(map: map["author"]) : null;
    liked = map["liked"] ?? false;
  }
}
