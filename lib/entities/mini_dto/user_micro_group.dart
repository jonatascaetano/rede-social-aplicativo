class UserMicroGroup {
  late String id;
  late String name;
  late String imageProfile;
  late bool userIsMember;
  late bool userIsModerator;
  late bool userIsSilenced;

  UserMicroGroup.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    imageProfile = map["imageProfile"];
    userIsMember = map["userIsMember"];
    userIsModerator = map["userIsModerator"];
    userIsSilenced = map["userIsSilenced"];
  }
}
