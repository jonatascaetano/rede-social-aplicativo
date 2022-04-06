class GroupDTO {
  late String name;
  late String description;
  late String idCreator;
  late String? image;
  late String creationDate;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["name"] = name;
    map["description"] = description;
    map["idCreator"] = idCreator;
    map["image"] = image;
    map["creationDate"] = creationDate;
    return map;
  }

  GroupDTO({
    required this.name,
    required this.description,
    required this.idCreator,
    required this.image,
    required this.creationDate,
  });
}
