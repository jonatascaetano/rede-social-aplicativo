import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class FollowerMini {
  late String? id;
  late DateTime? release;
  late UserMini? user;
  late List<UserMini>? following;

  FollowerMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    user = map["user"];
    following = map["following"];
  }
}
