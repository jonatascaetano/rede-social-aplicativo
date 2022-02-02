class CommentDTO {
  late String? idComment;
  late String idUser;
  late String idPost;
  late String? body;
  late String? release;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idComment"] = idComment;
    map["idUser"] = idUser;
    map["idPost"] = idPost;
    map["body"] = body;
    map["release"] = release;
    return map;
  }

  CommentDTO({
    required this.idComment,
    required this.idUser,
    required this.idPost,
    required this.body,
    required this.release,
  });
}
