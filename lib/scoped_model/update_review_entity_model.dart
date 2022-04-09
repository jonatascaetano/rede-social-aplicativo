import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'entity_model2.dart';

class UpdateReviewEntityModel extends Model {
  bool load = false;

  updateReview({required entitySaveDTO, required BuildContext contextEntityPage, required BuildContext contextUpdateReviewPage}) async {
    load = true;
    notifyListeners();
    ScopedModel.of<EntityModel2>(contextEntityPage).updateReviewEntitySave(entitySaveDTO: entitySaveDTO, context: contextEntityPage, contextUpdateReviewPage: contextUpdateReviewPage, contextEntityPage: contextEntityPage);
  }
}
