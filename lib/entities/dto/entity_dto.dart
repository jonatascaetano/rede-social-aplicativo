class EntityDTO {
  late String name;
  late String? description;
  late String typeEntity;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["name"] = name;
    map["description"] = description;
    map["typeEntity"] = typeEntity;
    return map;
  }

  EntityDTO({
    required this.name,
    required this.description,
    required this.typeEntity,
  });
}
