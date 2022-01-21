import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/season_dto.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/scoped_model/new_season_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

// ignore: must_be_immutable
class NewSeasonEntity extends StatefulWidget {
  EntityMini entityMini;
  BuildContext context;
  NewSeasonEntity({required this.entityMini, required this.context, Key? key})
      : super(key: key);

  @override
  _NewSeasonEntityState createState() => _NewSeasonEntityState();
}

class _NewSeasonEntityState extends State<NewSeasonEntity> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController numberSeason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<NewSeasonModel>(
          model: NewSeasonModel(),
          child: ScopedModelDescendant<NewSeasonModel>(
              builder: (context, child, season) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: Text(
                  "New season",
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
                        TextField(
                          controller: numberSeason,
                          minLines: 1,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            label: Text("season number"),
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
                            SeasonDTO seasonDTO = SeasonDTO(
                              name: name.text,
                              description: description.text,
                              numberSeason: int.parse(numberSeason.text),
                            );
                            season.createSeason(
                              seasonDTO: seasonDTO,
                              idEntity: widget.entityMini.id,
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
                  season.load
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
