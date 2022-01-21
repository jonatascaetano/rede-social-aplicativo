import 'package:social_network_application/entities/mini_dto/season_mini.dart';

class EpisodeMini {
  late String id;
  late String name;
  late String? description;
  late int numberEpisode;
  late String? image;
  late int evaluationQuantity;
  late double evaluationAverage;
  late String typeObject;
  late SeasonMini season;

  EpisodeMini.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    image = map["image"];
    description = map["description"];
    numberEpisode = map["numberEpisode"];
    evaluationQuantity = map["evaluationQuantity"];
    evaluationAverage = map["evaluationAverage"];
    typeObject = map['typeObject'];
    season = SeasonMini.fromMap(map: map['season']);
  }
}
