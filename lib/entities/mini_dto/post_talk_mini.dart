import 'package:social_network_application/entities/mini_dto/user_micro_widget.dart';

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
  late UserMicroWidget? author;
  late bool liked;
  late UserMicroWidget? like;
  late String? title;

  PostTalkMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    body = map["body"];
    typePost = map["typePost"];
    typePostVisibility = map["typePostVisibility"];
    likeQuantity = map["likeQuantity"];
    commentQuantity = map["commentQuantity"];
    typeObject = map["typeObject"];
    spoiler = map["spoiler"] ?? false;
    author = map["author"] != null ? UserMicroWidget.fromMap(map: map["author"]) : null;
    liked = map["liked"] ?? false;
    like = map["like"] != null ? UserMicroWidget.fromMap(map: map["like"]) : null;
    title = map["title"];
  }
}
