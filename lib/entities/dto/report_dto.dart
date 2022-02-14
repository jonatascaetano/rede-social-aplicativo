class ReportDTO {
  late String? id;
  late String? levelReport;
  late String? idReported;
  late String? typeReport;
  late String? idAuthor;
  late String? release;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["levelReport"] = levelReport;
    map["idReported"] = idReported;
    map["typeReport"] = typeReport;
    map["idAuthor"] = idAuthor;
    map["release"] = release;
    return map;
  }

  ReportDTO({
    required this.id,
    required this.levelReport,
    required this.idReported,
    required this.typeReport,
    required this.idAuthor,
    required this.release,
  });
}
