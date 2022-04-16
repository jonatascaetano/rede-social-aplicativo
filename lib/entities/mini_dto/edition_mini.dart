import 'package:social_network_application/entities/mini_dto/entity_micro.dart';
import 'package:social_network_application/entities/mini_dto/user_micro_widget.dart';

class EditionMini {
  late String id;
  late UserMicroWidget? user;
  late EntityMicro? entity;
  late String? attribute;
  late Object? previus;
  late Object? current;
  late DateTime? release;
  late String typeObject;
  late String level;

  EditionMini.fromMap({required Map map}) {
    id = map["id"];
    user = map["user"] != null ? UserMicroWidget.fromMap(map: map["user"]) : null;
    entity = map["entity"];
    attribute = map["attribute"];
    previus = map["previus"];
    current = map["current"];
    release = map["release"];
    typeObject = map["typeObject"];
    level = map["level"];
  }
}
