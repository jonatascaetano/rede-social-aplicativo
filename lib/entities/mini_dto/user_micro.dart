class UserMicro {
  late String id;
  late String name;
  late String? imageProfile;
  late bool following;
  late bool follower;

  UserMicro.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    imageProfile = map["imageProfile"];
    following = map["following"];
    follower = map["follower"];
  }
}
