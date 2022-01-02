import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class InvitationMini {
  late String id;
  late DateTime? release;
  late String? value;
  late UserMini? user;
  late String typeObject;
  late List<UserMini>? invited = [];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["release"] = release;
    map["value"] = value;
    map["user"] = user;
    map["typeObject"] = typeObject;
    map["invited"] = invited;
    return map;
  }

  InvitationMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    value = map["value"];
    user = UserMini.fromMap(map: map["user"]);
    typeObject = map["typeObject"];
    for (Map map in map["invited"]) {
      UserMini userMini = UserMini.fromMap(map: map);
      invited!.add(userMini);
    }
  }
}
