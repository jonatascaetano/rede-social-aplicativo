import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class WorkerMini {
  late String id;
  late DateTime? release;
  late String role;
  late String typeWorker;
  late String typeObject;
  late UserMini user;
  late EntityMini entity;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["release"] = release;
    map["role"] = role;
    map["typeWorker"] = typeWorker;
    map["typeObject"] = typeObject;
    map["user"] = user.toMap();
    map["entity"] = entity.toMap();
    return map;
  }

  WorkerMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    role = map["role"];
    typeWorker = map["typeWorker"];
    typeObject = map["typeObject"];
    user = UserMini.fromMap(map: map["user"]);
    entity = EntityMini.fromMap(map: map["entity"]);
  }
}
