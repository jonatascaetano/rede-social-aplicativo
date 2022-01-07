import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/converts_enum/convert_to_enum.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/scoped_model/auxiliar/language_model.dart';
import 'package:social_network_application/scoped_model/entity_model.dart';
import 'package:social_network_application/widgets/mini_entities/season_mini_entity.dart';
import 'package:social_network_application/widgets/mini_entities/worker_mini_entity.dart';

// ignore: must_be_immutable
class Entity extends StatefulWidget {
  EntityMini entityMini;
  Entity({required this.entityMini, Key? key}) : super(key: key);

  @override
  _EntityState createState() => _EntityState();
}

class _EntityState extends State<Entity> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<EntityModel>(
        model: EntityModel(entityId: widget.entityMini.id),
        child: ScopedModelDescendant<EntityModel>(
            builder: (context, child, entity) {
          return Scaffold(
              body: Stack(
            children: [
              !entity.entityMiniIsNull
                  ? ListView(
                      children: [
                        SizedBox(
                            height: 300,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: entity.entityMini.images.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 300,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            entity.entityMini.images[index]),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  );
                                })),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          entity.entityMini.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          LanguageModel()
                              .typeEntities[
                                  ConvertToEnum.convertTypeEntityToValue(
                                      typeEntity: entity.entityMini.typeEntity)]
                              .toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          entity.entityMini.evaluationAverage.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          '( ' +
                              entity.entityMini.evaluationQuantity.toString() +
                              ' evaluations)',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        entity.seasons.isNotEmpty
                            ? SizedBox(
                                height: 200,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: entity.seasons.length,
                                    itemBuilder: (context, index) {
                                      return SeasonMiniEntity(
                                        seasonMini: entity.seasons[index],
                                      );
                                    }),
                              )
                            : Container(),
                        entity.seasons.isNotEmpty
                            ? const SizedBox(
                                height: 16.0,
                              )
                            : Container(),
                        entity.entityMini.description != null
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 0.0, 0.0, 16.0),
                                child: Text(
                                  entity.entityMini.description!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text('edit ' +
                                  LanguageModel()
                                      .typeEntities[ConvertToEnum
                                          .convertTypeEntityToValue(
                                              typeEntity:
                                                  entity.entityMini.typeEntity)]
                                      .toString()
                                      .toLowerCase())),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        entity.workers.isNotEmpty
                            ? SizedBox(
                                height: 200,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: entity.workers.length,
                                    itemBuilder: (context, index) {
                                      return WorkerMiniEntity(
                                        workerMini: entity.workers[index],
                                        idUser: entity.idUser,
                                      );
                                    }),
                              )
                            : Container(),
                        entity.workers.isNotEmpty
                            ? const SizedBox(
                                height: 16.0,
                              )
                            : Container(),
                      ],
                    )
                  : Container(),
              entity.load
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
          ));
        }));
  }
}
