class EntityMini {
  late String id;
  late String name;
  late String? description;
  late int evaluationQuantity;
  late double evaluationAverage;
  late int seasonQuantity;
  late String typeObject;
  late String typeEntity;
  late String? image;
  int category1 = 0;
  int category2 = 0;
  int category3 = 0;
  int category4 = 0;

  EntityMini.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    description = map["description"];
    evaluationQuantity = map["evaluationQuantity"];
    evaluationAverage = map["evaluationAverage"];
    seasonQuantity = map["seasonQuantity"];
    typeObject = map['typeObject'];
    typeEntity = map['typeEntity'];
    image = map["image"];
    category1 = map["category1"];
    category2 = map["category2"];
    category3 = map["category3"];
    category4 = map["category4"];
  }
}
