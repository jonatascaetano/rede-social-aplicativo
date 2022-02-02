import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class CommentMini {
  late String id;
  late String release;
  late String body;
  late UserMini user;
  late String typeObject;
  late int likeQuantity = 0;

  CommentMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    body = map["body"];
    user = UserMini.fromMap(map: map["user"]);
    typeObject = map["typeObject"];
    likeQuantity = map["likeQuantity"];
  }
}
