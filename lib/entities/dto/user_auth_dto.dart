class UserAuthDTO {
  late String email;
  late String password;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["email"] = email;
    map["password"] = password;
    return map;
  }

  UserAuthDTO.fromMap({required Map map}) {
    email = map["email"];
    password = map["password"];
  }
}
