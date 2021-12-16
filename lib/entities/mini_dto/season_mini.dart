class SeasonMini {
  late String id;
  late String name;
  late String image;
  late String description;
  late int number;
  late int evaluationQuantity;
  late double evaluationAverage;
  late int episode;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["name"] = name;
    map["image"] = image;
    map["description"] = description;
    map["number"] = number;
    map["evaluationQuantity"] = evaluationQuantity;
    map["evaluationAverage"] = evaluationAverage;
    map["episode"] = episode;
    return map;
  }

  SeasonMini.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    image = map["image"];
    description = map["description"];
    number = map["number"];
    evaluationQuantity = map["evaluationQuantity"];
    evaluationAverage = map["evaluationAverage"];
    episode = map["episode"];
  }
}
