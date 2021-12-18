class EpisodeCreation {
  late String idEpisode;
  late String name;
  late String description;
  late String image;
  late DateTime release;
  late int number;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idEpisode"] = idEpisode;
    map["name"] = name;
    map["description"] = description;
    map["image"] = image;
    map["release"] = release;
    map["number"] = number;
    return map;
  }

  EpisodeCreation({required this.idEpisode, required this.name, required this.description, required this.image,
    required this.release, required this.number});

  EpisodeCreation.fromMap({required Map map}) {
    idEpisode = map["idEpisode"];
    name = map["name"];
    description = map["description"];
    image = map["image"];
    release = map["release"];
    number = map["number"];
  }
}
