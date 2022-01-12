class WorkerDTO {
  late String idUser;
  late String idEntity;
  late String role;
  late String typeWorker;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idUser"] = idUser;
    map["idEntity"] = idEntity;
    map["role"] = role;
    map["typeWorker"] = typeWorker;
    return map;
  }

  WorkerDTO({
    required this.idUser,
    required this.idEntity,
    required this.role,
    required this.typeWorker,
  });
}
