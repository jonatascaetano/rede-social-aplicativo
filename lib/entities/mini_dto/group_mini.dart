import 'package:social_network_application/entities/mini_dto/user_mini.dart';

class GroupMini {
  late String id;
  late String name;
  late String description;
  late UserMini? creator;
  late String creationDate;
  late String image;
  late int quantityMembers;
  late int quantityModerator;
  late int quantitySilenced;
  late int quantityPosts;
  late bool userIsMember;
  late bool userIsModerator;
  late bool userIsSilenced;

  GroupMini.fromMap({required Map map}) {
    id = map["id"];
    name = map["name"];
    description = map["description"];
    creator = map["creator"] != null ? UserMini.fromMap(map: map["creator"]) : null;
    creationDate = map["creationDate"];
    image = map["image"];
    quantityMembers = map["quantityMembers"];
    quantityModerator = map["quantityModerator"];
    quantitySilenced = map["quantitySilenced"];
    quantityPosts = map["quantityPosts"];
    userIsMember = map["userIsMember"];
    userIsModerator = map["userIsModerator"];
    userIsSilenced = map['userIsSilenced'];
  }
}
