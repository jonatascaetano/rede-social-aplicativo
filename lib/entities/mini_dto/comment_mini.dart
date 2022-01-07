import 'package:social_network_application/entities/mini_dto/post_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class CommentMini {
  late String id;
  late DateTime? release;
  late String? body;
  late UserMini? user;
  late PostMini? post;

  CommentMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    body = map["body"];
    user = map["user"];
    post = map["post"];
  }
}
