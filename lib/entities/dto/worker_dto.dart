class WorkerDTO {
  late String idUser;
  late String idEntity;
  late String role;
  late String level;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idUser"] = idUser;
    map["idEntity"] = idEntity;
    map["role"] = role;
    map["level"] = level;
    return map;
  }

  WorkerDTO({
    required this.idUser,
    required this.idEntity,
    required this.role,
    required this.level,
  });
}
