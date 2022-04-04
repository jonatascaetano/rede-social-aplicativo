class PostTalkGroupDTO {
  late String idPost;
  late String release;
  late String body;
  late bool spoiler;
  late String idAuthor;
  late String idGroup;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idPost"] = idPost;
    map["release"] = release;
    map["body"] = body;
    map["spoiler"] = spoiler;
    map["idAuthor"] = idAuthor;
    map["idGroup"] = idGroup;
    return map;
  }

  PostTalkGroupDTO({
    required this.idPost,
    required this.release,
    required this.body,
    required this.spoiler,
    required this.idAuthor,
    required this.idGroup,
  });
}
