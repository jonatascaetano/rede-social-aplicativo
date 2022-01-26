import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class WorkerMini {
  late String id;
  late DateTime? release;
  late String role;
  late String level;
  late String typeObject;
  late UserMini user;
  late EntityMini entity;

  WorkerMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    role = map["role"];
    level = map["level"];
    typeObject = map["typeObject"];
    user = UserMini.fromMap(map: map["user"]);
    entity = EntityMini.fromMap(map: map["entity"]);
  }
}
