class CommentDTO {
  late String? idComment;
  late String idAuthor;
  late String idPost;
  late String? body;
  late String? release;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idComment"] = idComment;
    map["idAuthor"] = idAuthor;
    map["idPost"] = idPost;
    map["body"] = body;
    map["release"] = release;
    return map;
  }

  CommentDTO({
    required this.idComment,
    required this.idAuthor,
    required this.idPost,
    required this.body,
    required this.release,
  });
}
