import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/entity_save_dto.dart';
import 'package:social_network_application/scoped_model/entity_model2.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

// ignore: must_be_immutable
class Evaluation extends StatefulWidget {
  int value, evaluation;
  BuildContext contextEntityPage;
  Evaluation({required this.value, required this.evaluation, required this.contextEntityPage, Key? key}) : super(key: key);

  @override
  _EvaluationState createState() => _EvaluationState();
}

class _EvaluationState extends State<Evaluation> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              if (widget.evaluation != widget.value && ScopedModel.of<EntityModel2>(widget.contextEntityPage).entitySaveMini != null) {
                EntitySaveDTO entitySaveDTO = EntitySaveDTO(
                  idEntitySave: ScopedModel.of<EntityModel2>(widget.contextEntityPage).entitySaveMini!.id,
                  idUser: null,
                  idEntity: null,
                  idSeason: null,
                  idEpisode: null,
                  category: null,
                  goal: null,
                  rated: null,
                  reviewed: null,
                  evaluation: widget.value,
                  review: null,
                  level: null,
                  spoiler: false,
                  release: null,
                );
                ScopedModel.of<EntityModel2>(widget.contextEntityPage).updateEvaluationEntitySave(entitySaveDTO: entitySaveDTO, context: context, contextEntityPage: widget.contextEntityPage);
              }
            },
            icon: Icon(
              Icons.star,
              size: 40,
              color: widget.evaluation >= widget.value ? Colors.yellow[700] : theme.icon,
            )),
      );
    });
  }
}
