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

  WorkerDTO({
    required this.idUser,
    required this.idEntity,
    required this.role,
  });
}
