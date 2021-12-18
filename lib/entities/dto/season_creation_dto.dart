class SeasonCreationDTO {
  late String name;
  late String image;
  late String description;
  late DateTime release;
  late int number;
  late int episode;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["name"] = name;
    map["image"] = image;
    map["description"] = description;
    map["release"] = release;
    map["number"] = number;
    map["episode"] = episode;
    return map;
  }

  SeasonCreationDTO({required this.name, required this.image, required this.description, required this.release,
      required this.number, required this.episode});

  SeasonCreationDTO.fromMap({required Map map}) {
    name = map["name"];
    image = map["image"];
    description = map["description"];
    release = map["release"];
    number = map["number"];
    episode = map["episode"];
  }
}
