import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class WorkerMini {
  late String id;
  late DateTime release;
  late String role;
  late UserMini user;
  late EntityMini entity;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["release"] = release;
    map["role"] = role;
    map["user"] = user;
    map["entity"] = entity;
    return map;
  }

  WorkerMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    role = map["role"];
    user = map["user"];
    entity = map["entity"];
  }
}
