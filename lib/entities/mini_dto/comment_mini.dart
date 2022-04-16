import 'package:social_network_application/entities/mini_dto/user_micro_widget.dart';

class CommentMini {
  late String id;
  late String release;
  late String body;
  late UserMicroWidget author;
  late String typeObject;
  late int likeQuantity = 0;
  late bool liked;
  late String? typeComment;

  CommentMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    body = map["body"];
    author = UserMicroWidget.fromMap(map: map["author"]);
    typeObject = map["typeObject"];
    likeQuantity = map["likeQuantity"] ?? 0;
    liked = map["liked"] ?? false;
    typeComment = map["typeComment"];
  }
}
