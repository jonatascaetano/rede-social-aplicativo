class UserMini {
  late String id;
  late String name;
  late String? image;
  late String? description;
  late String? city;
  late String email;
  late String password;
  late bool checked;
  late bool privacy;
  late bool status;
  late int following;
  late int followers;
  late String typeObject;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["name"] = name;
    map["image"] = image;
    map["description"] = description;
    map["city"] = city;
    map["email"] = email;
    map["password"] = password;
    map["checked"] = checked;
    map["privacy"] = privacy;
    map["status"] = status;
    map["following"] = following;
    map["followers"] = followers;
    map["typeObject"] = typeObject;
    return map;
  }

  UserMini.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    image = map["image"];
    description = map["description"];
    city = map["city"];
    email = map["email"];
    password = map["password"];
    checked = map["checked"];
    privacy = map["privacy"];
    status = map["status"];
    following = map["following"];
    followers = map["followers"];
    typeObject = map['typeObject'];
  }
}
