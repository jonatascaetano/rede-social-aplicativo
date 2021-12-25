import 'package:social_network_application/enuns/type_entity.dart';
import 'package:social_network_application/enuns/type_object.dart';

class ConvertToEnum {
  int toTypeObject({required String type}) {
    TypeObject.values.map((e) {
      // ignore: avoid_print
      print(e);
    });
    for (var value in TypeObject.values) {
      if (type.toLowerCase() == value.toString().toLowerCase()) {
        return value.index;
      }
    }
    return 0;
  }

  int toTypeEntity({required String type}) {
    TypeEntity.values.map((e) {
      // ignore: avoid_print
      print(e);
    });
    for (var value in TypeEntity.values) {
      // ignore: avoid_print
      print(value);
      if (type.toLowerCase() == value.toString().toLowerCase()) {
        return value.index;
      }
    }
    return 0;
  }
}
