import 'package:social_network_application/entities/mini_dto/user_micro_widget.dart';

class InvitationMini {
  late String id;
  late DateTime? release;
  late String? value;
  late UserMicroWidget? user;
  late String typeObject;
  late List<UserMicroWidget>? invited = [];

  InvitationMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    value = map["value"];
    user = UserMicroWidget.fromMap(map: map["user"]);
    typeObject = map["typeObject"];
    for (Map map in map["invited"]) {
      UserMicroWidget userMicroWidget = UserMicroWidget.fromMap(map: map);
      invited!.add(userMicroWidget);
    }
  }
}
