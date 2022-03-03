import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class CommentMini {
  late String id;
  late String? release;
  late String body;
  late UserMini author;
  late String typeObject;
  late int likeQuantity = 0;
  late bool liked;
  late String? typeComment;

  CommentMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    body = map["body"];
    author = UserMini.fromMap(map: map["author"]);
    typeObject = map["typeObject"];
    likeQuantity = map["likeQuantity"];
    liked = map["liked"] ?? false;
    typeComment = map["typeComment"];
  }
}
