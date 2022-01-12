import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/season_dto.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/scoped_model/new_season_model.dart';

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
    return ScopedModel<NewSeasonModel>(
        model: NewSeasonModel(),
        child: ScopedModelDescendant<NewSeasonModel>(
            builder: (context, child, season) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: const Text(
                "New season",
                style: TextStyle(
                  color: Colors.purple,
                ),
              ),
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: name,
                        minLines: 1,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          label: Text("name"),
                        ),
                      ),
                      TextField(
                        controller: description,
                        minLines: 10,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          label: Text("description"),
                        ),
                      ),
                      TextField(
                        controller: numberSeason,
                        minLines: 1,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          label: Text("season number"),
                        ),
                      ),
                      TextButton(
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
                        child: const Text("Confirm"),
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
  }
}
