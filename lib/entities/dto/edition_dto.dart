class EditionDTO {
  late String idUser;
  late String idEntity;
  late String idSeason;
  late String idEpisode;
  late DateTime release;
  late Object previous;
  late Object current;
  late String attribute;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idUser"] = idUser;
    map["idEntity"] = idEntity;
    map["idSeason"] = idSeason;
    map["idEpisode"] = idEpisode;
    map["release"] = release;
    map["previous"] = previous;
    map["current"] = current;
    map["attribute"] = attribute;
    return map;
  }

  EditionDTO({
    required this.idUser,
    required this.idEntity,
    required this.idSeason,
    required this.idEpisode,
    required this.release,
    required this.previous,
    required this.current,
    required this.attribute,
  });
}
