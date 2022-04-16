class GroupMicro {
  late String id;
  late String name;
  late String? image;
  late String description;

  GroupMicro.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    image = map["image"];
    description = map["description"];
  }
}
