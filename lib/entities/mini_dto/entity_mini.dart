class EntityMini {
  late String id;
  late String name;
  late String? image;
  late String? description;
  late int evaluationQuantity;
  late double evaluationAverage;
  late int season;
  late String typeObject;
  late String typeEntity;
  late String? genre;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["name"] = name;
    map["image"] = image;
    map["description"] = description;
    map["evaluationQuantity"] = evaluationQuantity;
    map["evaluationAverage"] = evaluationAverage;
    map["season"] = season;
    map["typeObject"] = typeObject;
    map["typeEntity"] = typeEntity;
    map["genre"] = genre;
    return map;
  }

  EntityMini.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    image = map["image"];
    description = map["description"];
    evaluationQuantity = map["evaluationQuantity"];
    evaluationAverage = map["evaluationAverage"];
    season = map["season"];
    typeObject = map['typeObject'];
    typeEntity = map['typeEntity'];
    genre = map["genre"];
  }
}
