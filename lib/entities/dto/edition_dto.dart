class EditionDTO {
  late String idUser;
  late String idEntity;
  late String idSeason;
  late String idEpisode;
  late DateTime release;
  late Object previus;
  late Object current;
  late String attribute;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idUser"] = idUser;
    map["idEntity"] = idEntity;
    map["idSeason"] = idSeason;
    map["idEpisode"] = idEpisode;
    map["release"] = release;
    map["previus"] = previus;
    map["current"] = current;
    map["attribute"] = attribute;
    return map;
  }

  EditionDTO.fromMap({required Map map}) {
    idUser = map["idUser"];
    idEntity = map["idEntity"];
    idSeason = map["idSeason"];
    idEpisode = map["idEpisode"];
    release = map["release"];
    previus = map["previus"];
    current = map["current"];
    attribute = map["attribute"];
  }
}
