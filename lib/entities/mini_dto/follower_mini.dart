import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class FollowerMini {
  late String? id;
  late DateTime? release;
  late UserMini? user;
  late List<UserMini>? following;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["release"] = release;
    map["user"] = user;
    map["following"] = following;
    return map;
  }

  FollowerMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    user = map["user"];
    following = map["following"];
  }
}
