class EntityMini {
  late String id;
  late String name;
  late String? description;
  late int evaluationQuantity;
  late double evaluationAverage;
  late int seasonQuantity;
  late String typeObject;
  late String typeEntity;
  late List<dynamic> images = [];

  EntityMini.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    description = map["description"];
    evaluationQuantity = map["evaluationQuantity"];
    evaluationAverage = map["evaluationAverage"];
    seasonQuantity = map["seasonQuantity"];
    typeObject = map['typeObject'];
    typeEntity = map['typeEntity'];
    images = map["images"];
  }
}
