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

  EntitySaveDTO({
    required this.idEntitySave,
    required this.idUser,
    required this.idEntity,
    required this.idSeason,
    required this.idEpisode,
    required this.category,
    required this.release,
    required this.goal,
    required this.rated,
    required this.review,
    required this.type,
  });
}
