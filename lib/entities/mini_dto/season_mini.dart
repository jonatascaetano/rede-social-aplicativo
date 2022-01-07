import 'package:social_network_application/entities/mini_dto/entity_mini.dart';

class SeasonMini {
  late String id;
  late String name;
  late List<dynamic> images = [];
  late String? description;
  late int numberSeason;
  late int evaluationQuantity;
  late double evaluationAverage;
  late int episodeQuantity;
  late String typeObject;
  late EntityMini entity;

  SeasonMini.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    images = map["images"];
    description = map["description"];
    numberSeason = map["numberSeason"];
    evaluationQuantity = map["evaluationQuantity"];
    evaluationAverage = map["evaluationAverage"];
    episodeQuantity = map["episodeQuantity"];
    typeObject = map['typeObject'];
    entity = EntityMini.fromMap(map: map["entity"]);
  }
}
