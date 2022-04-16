import 'package:social_network_application/entities/mini_dto/user_micro_widget.dart';

class ReportMini {
  late String id;
  late String typeObject;
  late String levelReport;
  late String idReported;
  late String typeReport;
  late UserMicroWidget author;
  late bool checked;
  late String release;

  ReportMini.fromMap({required Map map}) {
    id = map["id"];
    typeObject = map["typeObject"];
    levelReport = map["levelReport"];
    idReported = map["idReported"];
    typeReport = map["typeReport"];
    author = map["author"];
    checked = map["checked"];
    release = map["release"];
  }
}
