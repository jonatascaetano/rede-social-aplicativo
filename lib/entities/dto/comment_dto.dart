class CommentDTO {
  late String idComment;
  late DateTime release;
  late String body;
  late String idUser;
  late DateTime idPost;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["idComment"] = idComment;
    map["release"] = release;
    map["body"] = body;
    map["idUser"] = idUser;
    map["idPost"] = idPost;
    return map;
  }

  CommentDTO.fromMap({required Map map}) {
    idComment = map["idComment"];
    release = map["release"];
    body = map["body"];
    idUser = map["idUser"];
    idPost = map["idPost"];
  }
}
