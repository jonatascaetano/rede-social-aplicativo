import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class InvitationMini {
  late DateTime release;
  late String value;
  late UserMini user;
  late List<UserMini> invited;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["release"] = release;
    map["value"] = value;
    map["user"] = user;
    map["invited"] = invited;
    return map;
  }

  InvitationMini.fromMap({required Map map}) {
    release = map["release"];
    value = map["value"];
    user = map["user"];
    invited = map["invited"];
  }
}
