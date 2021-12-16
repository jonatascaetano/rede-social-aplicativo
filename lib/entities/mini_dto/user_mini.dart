class UserMini {
  late String id;
  late String name;
  late String image;
  late String description;
  late String city;
  late bool checked;
  late bool privacy;
  late bool status;
  late int following;
  late int followers;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["name"] = name;
    map["image"] = image;
    map["description"] = description;
    map["city"] = city;
    map["checked"] = checked;
    map["privacy"] = privacy;
    map["status"] = status;
    map["following"] = following;
    map["followers"] = followers;
    return map;
  }

  UserMini.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    image = map["image"];
    description = map["description"];
    city = map["city"];
    checked = map["checked"];
    privacy = map["privacy"];
    status = map["status"];
    following = map["following"];
    followers = map["followers"];
  }
}
