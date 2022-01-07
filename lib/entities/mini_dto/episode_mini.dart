class EpisodeMini {
  late String id;
  late String name;
  late String? image;
  late String? description;
  late int number;
  late int evaluationQuantity;
  late double evaluationAverage;
  late String typeObject;

  EpisodeMini.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    image = map["image"];
    description = map["description"];
    number = map["number"];
    evaluationQuantity = map["evaluationQuantity"];
    evaluationAverage = map["evaluationAverage"];
    typeObject = map['typeObject'];
  }
}
