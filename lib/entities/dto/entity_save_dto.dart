class EntitySaveDTO {
  late String idEntitySave;
  late String idUser;
  late String idEntity;
  late String idSeason;
  late String idEpisode;
  late int category;
  late DateTime release;
  late bool goal;
  late bool rated;
  late bool review;
  late int type;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idEntitySave"] = idEntitySave;
    map["idUser"] = idUser;
    map["idEntity"] = idEntity;
    map["idSeason"] = idSeason;
    map["idEpisode"] = idEpisode;
    map["category"] = category;
    map["release"] = release;
    map["goal"] = goal;
    map["rated"] = rated;
    map["review"] = review;
    map["type"] = type;
    return map;
  }

  EntitySaveDTO.fromMap({required Map map}) {
    idEntitySave = map["idEntitySave"];
    idUser = map["idUser"];
    idEntity = map["idEntity"];
    idSeason = map["idSeason"];
    idEpisode = map["idEpisode"];
    category = map["category"];
    release = map["release"];
    goal = map["goal"];
    rated = map["rated"];
    review = map["review"];
    type = map["type"];
  }
}
