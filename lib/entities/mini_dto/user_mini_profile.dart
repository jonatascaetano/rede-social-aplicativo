class UserMiniProfile {
  late String id;
  late String name;
  late String imageProfile;
  late String description;
  late bool status;
  late int quantityFollowing;
  late int quantityFollowers;
  late String typeObject;
  late bool following;
  late bool follower;

  UserMiniProfile.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    imageProfile = map["imageProfile"];
    description = map["description"];
    status = map["status"];
    quantityFollowing = map["quantityFollowing"];
    quantityFollowers = map["quantityFollowers"];
    typeObject = map["typeObject"];
    following = map["following"];
    follower = map["follower"];
  }
}
