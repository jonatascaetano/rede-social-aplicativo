class WorkerDTO {
  late String idUser;
  late String idEntity;
  late String role;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idUser"] = idUser;
    map["idEntity"] = idEntity;
    map["role"] = role;
    return map;
  }

  WorkerDTO.fromMap({required Map map}) {
    idUser = map["idUser"];
    idEntity = map["idEntity"];
    role = map["role"];
  }
}
