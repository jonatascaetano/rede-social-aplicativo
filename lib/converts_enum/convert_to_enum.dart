import 'package:social_network_application/enuns/type_entity.dart';
import 'package:social_network_application/enuns/type_object.dart';

class ConvertToEnum {
  static convertTypeObjectToValue({required String typeObject}) {
    late int value;
    switch (typeObject) {
      case TypeObject.USER:
        value = 0;
        break;
      case TypeObject.ENTITY:
        value = 1;
        break;
      case TypeObject.SEASON:
        value = 2;
        break;
      case TypeObject.EPISODE:
        value = 3;
        break;
      case TypeObject.WORKER:
        value = 4;
        break;
      case TypeObject.POST:
        value = 5;
        break;
      case TypeObject.INVITATION:
        value = 6;
        break;
      case TypeObject.FOLLOWER:
        value = 7;
        break;
      case TypeObject.EVALUATION:
        value = 8;
        break;
      case TypeObject.ENTITY_SAVE:
        value = 9;
        break;
      case TypeObject.EDITION:
        value = 10;
        break;
      case TypeObject.COMMENT:
        value = 11;
        break;
    }
    return value;
  }

  static convertTypeEntityToValue({required String typeEntity}) {
    late int value;
    switch (typeEntity) {
      case TypeEntity.MOVIES:
        value = 0;
        break;
      case TypeEntity.SERIES:
        value = 1;
        break;
      case TypeEntity.ANIMES:
        value = 2;
        break;
      case TypeEntity.NOVELS:
        value = 3;
        break;
      case TypeEntity.TV_SHOWS:
        value = 4;
        break;
      case TypeEntity.BOOKS:
        value = 5;
        break;
      case TypeEntity.GAMES:
        value = 6;
        break;
      case TypeEntity.WEB_PROGRAMS:
        value = 7;
        break;
      case TypeEntity.SONGS:
        value = 8;
        break;
      case TypeEntity.MUSIC_ALBUMS:
        value = 9;
        break;
      case TypeEntity.PLACES:
        value = 10;
        break;
      case TypeEntity.RECIPES:
        value = 11;
        break;
    }
    return value;
  }

  static convertValueToTypeEntity({required int index}) {
    late String value;
    switch (index) {
      case 0:
        value = TypeEntity.MOVIES;
        break;
      case 1:
        value = TypeEntity.SERIES;
        break;
      case 2:
        value = TypeEntity.ANIMES;
        break;
      case 3:
        value = TypeEntity.NOVELS;
        break;
      case 4:
        value = TypeEntity.NOVELS;
        break;
      case 5:
        value = TypeEntity.NOVELS;
        break;
      case 6:
        value = TypeEntity.NOVELS;
        break;
      case 7:
        value = TypeEntity.NOVELS;
        break;
      case 8:
        value = TypeEntity.NOVELS;
        break;
      case 9:
        value = TypeEntity.NOVELS;
        break;
      case 10:
        value = TypeEntity.NOVELS;
        break;
      case 11:
        value = TypeEntity.NOVELS;
        break;
    }
    return value;
  }
}
