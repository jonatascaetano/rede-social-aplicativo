import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/entity_dto.dart';
import 'package:social_network_application/scoped_model/new_entity_model.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

// ignore: must_be_immutable
class NewEntity extends StatefulWidget {
  String typeEntity;
  NewEntity({required this.typeEntity, Key? key}) : super(key: key);

  @override
  _NewEntityState createState() => _NewEntityState();
}

class _NewEntityState extends State<NewEntity> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<NewEntityModel>(
          model: NewEntityModel(),
          child: ScopedModelDescendant<NewEntityModel>(
              builder: (context, child, newEntity) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: Text(
                  "New " + widget.typeEntity.toLowerCase(),
                  style: TextStyle(
                    color: theme.title,
                    fontSize: 24.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 30.0),
                    child: ListView(
                      children: [
                        TextField(
                          controller: name,
                          minLines: 1,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            label: Text("name"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          controller: description,
                          minLines: 10,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            label: Text("description"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: theme.buttonMain,
                            elevation: 0.0,
                          ),
                          onPressed: () {
                            EntityDTO entityDTO = EntityDTO(
                                name: name.text,
                                description: description.text,
                                typeEntity: LanguageModel()
                                    .typeEntitiesMini[LanguageModel()
                                        .typeEntities
                                        .indexOf(widget.typeEntity)]
                                    .toUpperCase());
                            newEntity.createEntity(
                              entityDTO: entityDTO,
                              context: context,
                            );
                          },
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 2.0,
                              color: theme.buttonMainText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  newEntity.load
                      ? Positioned(
                          bottom: 0.1,
                          child: SizedBox(
                            height: 5.0,
                            width: MediaQuery.of(context).size.width,
                            child: const LinearProgressIndicator(),
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          }));
    });
  }
}
