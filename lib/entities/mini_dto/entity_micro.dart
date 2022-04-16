class EntityMicro {
  late String id;
  late String name;
  late String? image;
  late String description;
  late double evaluationAverage = 0.0;
  late String typeEntity;

  EntityMicro.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    image = map["image"];
    description = map["description"];
    evaluationAverage = map["evaluationAverage"];
    typeEntity = map["typeEntity"];
  }
}
