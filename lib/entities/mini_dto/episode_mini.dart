class EpisodeMini {
  late String id;
  late String name;
  late String? description;
  late int numberEpisode;
  late List<dynamic> images = [];
  late int evaluationQuantity;
  late double evaluationAverage;
  late String typeObject;

  EpisodeMini.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    images = map["images"];
    description = map["description"];
    numberEpisode = map["numberEpisode"];
    evaluationQuantity = map["evaluationQuantity"];
    evaluationAverage = map["evaluationAverage"];
    typeObject = map['typeObject'];
  }
}
