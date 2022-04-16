import 'package:social_network_application/entities/mini_dto/user_micro_widget.dart';

class FollowerMini {
  late String? id;
  late DateTime? release;
  late UserMicroWidget? user;
  late List<UserMicroWidget>? following;

  FollowerMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    user = map["user"] != null ? UserMicroWidget.fromMap(map: map["user"]) : null;
    following = map["following"];
  }
}
