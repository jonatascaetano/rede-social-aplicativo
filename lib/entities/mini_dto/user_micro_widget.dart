class UserMicroWidget {
  late String id;
  late String name;
  late String? imageProfile;

  UserMicroWidget.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    imageProfile = map["imageProfile"];
  }
}
