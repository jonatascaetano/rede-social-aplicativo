class EntitySaveDTO {
  late String? idEntitySave;
  late String? idUser;
  late String? idEntity;
  late String? idSeason;
  late String? idEpisode;
  late int? category;
  late bool? goal;
  late bool? rated;
  late bool? reviewed;
  late int? evaluation;
  late String? review;
  late String? typeEntitySave;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idEntitySave"] = idEntitySave;
    map["idUser"] = idUser;
    map["idEntity"] = idEntity;
    map["idSeason"] = idSeason;
    map["idEpisode"] = idEpisode;
    map["category"] = category;
    map["goal"] = goal;
    map["rated"] = rated;
    map["reviewed"] = reviewed;
    map["evaluation"] = evaluation;
    map["review"] = review;
    map["typeEntitySave"] = typeEntitySave;
    return map;
  }

  EntitySaveDTO({
    required this.idEntitySave,
    required this.idUser,
    required this.idEntity,
    required this.idSeason,
    required this.idEpisode,
    required this.category,
    required this.goal,
    required this.rated,
    required this.reviewed,
    required this.evaluation,
    required this.review,
    required this.typeEntitySave,
  });
}
