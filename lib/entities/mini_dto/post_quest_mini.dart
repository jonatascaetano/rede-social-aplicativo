import 'user_mini.dart';

class PostQuestMini {
  late String? id;
  late String? release;
  late String? body;
  late int typePost;
  late String? typePostVisibility;
  late int likeQuantity = 0;
  late int commentQuantity = 0;
  late String typeObject;
  late bool spoiler;
  late UserMini? author;
  late bool liked;

  late bool voted;
  late int valueVoted;
  late List<String> options = [];
  late List<int> votes = [];
  late int votesQuantity;

  PostQuestMini.fromMap({required Map map}) {
    id = map["id"];
    release = map["release"];
    body = map["body"];
    typePost = map["typePost"];
    typePostVisibility = typePostVisibility;
    likeQuantity = map["likeQuantity"];
    commentQuantity = map["commentQuantity"];
    typeObject = map["typeObject"];
    spoiler = map["spoiler"] ?? false;
    author =
        map["author"] != null ? UserMini.fromMap(map: map["author"]) : null;
    liked = map["liked"] ?? false;

    voted = map["voted"] ?? false;
    valueVoted = map["valueVoted"] ?? 0;
    options = map["options"];
    votes = map["votes"];
    votesQuantity = map["votesQuantity"];
  }
}
