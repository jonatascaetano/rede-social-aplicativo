import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';

class CategoryModel extends Model {
  List<EntitySaveMini> entitySaves = [];
  bool load = true;

  CategoryModel({required List<EntitySaveMini> entitySaveMinis, required int category}) {
    switch (category) {
      case 1:
        getCategory1(entitySaveMinis: entitySaveMinis);
        break;
      case 2:
        getCategory2(entitySaveMinis: entitySaveMinis);
        break;
      case 3:
        getCategory3(entitySaveMinis: entitySaveMinis);
        break;
      case 4:
        getCategory4(entitySaveMinis: entitySaveMinis);
        break;
      case 5:
        getCategory5(entitySaveMinis: entitySaveMinis);
        break;
      case 6:
        getCategory6(entitySaveMinis: entitySaveMinis);
        break;
      case 7:
        getCategory7(entitySaveMinis: entitySaveMinis);
        break;

      default:
    }
  }

  static getQuantityEvalued({
    required List<EntitySaveMini>? entitySaveMinis,
  }) {
    int value = 0;
    if (entitySaveMinis != null) {
      for (EntitySaveMini entitySaveMini in entitySaveMinis) {
        if (entitySaveMini.rated) {
          value++;
        }
      }
    }
    return value;
  }

  getCategory1({required List<EntitySaveMini> entitySaveMinis}) {
    load = true;
    notifyListeners();
    entitySaves = [];
    for (EntitySaveMini entitySaveMini in entitySaveMinis) {
      if (entitySaveMini.category == 1) {
        entitySaves.add(entitySaveMini);
      }
    }
    load = false;
    notifyListeners();
  }

  getCategory2({required List<EntitySaveMini> entitySaveMinis}) {
    load = true;
    notifyListeners();
    entitySaves = [];
    for (EntitySaveMini entitySaveMini in entitySaveMinis) {
      if (entitySaveMini.category == 2) {
        entitySaves.add(entitySaveMini);
      }
    }
    load = false;
    notifyListeners();
  }

  getCategory3({required List<EntitySaveMini> entitySaveMinis}) {
    load = true;
    notifyListeners();
    entitySaves = [];
    for (EntitySaveMini entitySaveMini in entitySaveMinis) {
      if (entitySaveMini.category == 3) {
        entitySaves.add(entitySaveMini);
      }
    }
    load = false;
    notifyListeners();
  }

  getCategory4({required List<EntitySaveMini> entitySaveMinis}) {
    load = true;
    notifyListeners();
    entitySaves = [];
    for (EntitySaveMini entitySaveMini in entitySaveMinis) {
      if (entitySaveMini.category == 4) {
        entitySaves.add(entitySaveMini);
      }
    }
    load = false;
    notifyListeners();
  }

  getCategory5({required List<EntitySaveMini> entitySaveMinis}) {
    load = true;
    notifyListeners();
    entitySaves = [];
    for (EntitySaveMini entitySaveMini in entitySaveMinis) {
      if (entitySaveMini.goal) {
        entitySaves.add(entitySaveMini);
      }
    }
    load = false;
    notifyListeners();
  }

  getCategory6({required List<EntitySaveMini> entitySaveMinis}) {
    load = true;
    notifyListeners();
    entitySaves = [];
    for (EntitySaveMini entitySaveMini in entitySaveMinis) {
      if (entitySaveMini.rated) {
        entitySaves.add(entitySaveMini);
      }
    }
    load = false;
    notifyListeners();
  }

  getCategory7({required List<EntitySaveMini> entitySaveMinis}) {
    load = true;
    notifyListeners();
    entitySaves = [];
    for (EntitySaveMini entitySaveMini in entitySaveMinis) {
      if (entitySaveMini.reviewed) {
        entitySaves.add(entitySaveMini);
      }
    }
    load = false;
    notifyListeners();
  }
}
