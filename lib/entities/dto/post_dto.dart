class PostDTO {
  late String idPost;
  late int type;
  late DateTime release;
  late String body;
  late int category;
  late String idUser;
  late String idEntity;
  late String idSeason;
  late String idEpisode;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idPost"] = idPost;
    map["type"] = type;
    map["release"] = release;
    map["body"] = body;
    map["category"] = category;
    map["idUser"] = idUser;
    map["idEntity"] = idEntity;
    map["idSeason"] = idSeason;
    map["idEpisode"] = idEpisode;
    return map;
  }

  PostDTO({required this.idPost, required this.type, required this.release, required this.body, required this.category,
    required this.idUser, required this.idEntity, required this.idSeason, required this.idEpisode});

  PostDTO.fromMap({required Map map}) {
    idPost = map["idPost"];
    type = map["type"];
    release = map["release"];
    body = map["body"];
    category = map["category"];
    idUser = map["idUser"];
    idEntity = map["idEntity"];
    idSeason = map["idSeason"];
    idEpisode = map["idEpisode"];
  }
}
