class UserUpdateDTO {
  late String idUser;
  late String name;
  late String email;
  late String password;
  late String image;
  late String description;
  late DateTime birthDate;
  late String city;
  late bool privacy;
  late bool status;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idUser"] = idUser;
    map["name"] = name;
    map["email"] = email;
    map["password"] = password;
    map["image"] = image;
    map["description"] = description;
    map["birthDate"] = birthDate;
    map["city"] = city;
    map["privacy"] = privacy;
    map["status"] = status;
    return map;
  }

  UserUpdateDTO({required this.idUser, required this.name, required this.email, required this.password, required this.image,
    required this.description, required this.birthDate, required this.city, required this.privacy, required this.status });

  UserUpdateDTO.fromMap({required Map map}) {
    idUser = map["idUser"];
    name = map["name"];
    email = map["email"];
    password = map["password"];
    image = map["image"];
    description = map["description"];
    birthDate = map["birthDate"];
    city = map["city"];
    privacy = map["privacy"];
    status = map["status"];
  }
}
