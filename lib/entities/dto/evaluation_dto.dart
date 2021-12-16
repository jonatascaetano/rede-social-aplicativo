class EvaluationDTO {
  late String idEvaluation;
  late String idUser;
  late String idEntity;
  late String idSeason;
  late String idEpisode;
  late double value;
  late DateTime release;
  late int type;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idEvaluation"] = idEvaluation;
    map["idUser"] = idUser;
    map["idEntity"] = idEntity;
    map["idSeason"] = idSeason;
    map["idEpisode"] = idEpisode;
    map["value"] = value;
    map["release"] = release;
    map["type"] = type;
    return map;
  }

  EvaluationDTO.fromMap({required Map map}) {
    idEvaluation = map["idEvaluation"];
    idUser = map["idUser"];
    idEntity = map["idEntity"];
    idSeason = map["idSeason"];
    idEpisode = map["idEpisode"];
    value = map["value"];
    release = map["release"];
    type = map["type"];
  }
}
