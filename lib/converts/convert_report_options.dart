import 'package:social_network_application/enuns/level_report.dart';
import 'package:social_network_application/enuns/type_report.dart';

class ConvertReportOptions {
  static convertTypeReportToEnum({required int index}) {
    late String value;
    switch (index) {
      case 0:
        value = TypeReport.SEXUAL_CONTENT;
        break;
      case 1:
        value = TypeReport.SEXUAL_CONTENT;
        break;
      case 2:
        value = TypeReport.SEXUAL_CONTENT;
        break;
      case 3:
        value = TypeReport.SEXUAL_CONTENT;
        break;
      case 4:
        value = TypeReport.SEXUAL_CONTENT;
        break;
    }
    return value;
  }

  static convertLevelReportToEnum({required int index}) {
    late String value;
    switch (index) {
      case 0:
        value = LevelReport.USER;
        break;
      case 1:
        value = LevelReport.POST;
        break;
      case 2:
        value = LevelReport.COMMENT;
        break;
    }
    return value;
  }
}
