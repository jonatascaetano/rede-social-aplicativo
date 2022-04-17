class PostQuestDTO {
  late String idPost;
  late String release;
  late String typePostVisibility;
  late bool spoiler;
  late String idAuthor;
  late String body;
  late List<String> options = [];
  late List<int> votes = [];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idPost"] = idPost;
    map["release"] = release;
    map["typePostVisibility"] = typePostVisibility;
    map["spoiler"] = spoiler;
    map["idAuthor"] = idAuthor;
    map["body"] = body;
    map["options"] = options;
    map["votes"] = votes;
    return map;
  }

  PostQuestDTO({
    required this.idPost,
    required this.release,
    required this.typePostVisibility,
    required this.spoiler,
    required this.idAuthor,
    required this.body,
    required this.options,
    required this.votes,
  });
}
