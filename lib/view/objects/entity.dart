import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/converts_enum/convert_to_enum.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/scoped_model/entity_model.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/view/entity/new_season_entity.dart';
import 'package:social_network_application/view/entity/new_worker_entity.dart';
import 'package:social_network_application/view/entity/update_entity.dart';
import 'package:social_network_application/widgets/mini_entities/evaluation.dart';
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
  void initState() {
    ScopedModel.of<EntityModel>(context).entityMiniIsNull = true;
    ScopedModel.of<EntityModel>(context).getId();
    ScopedModel.of<EntityModel>(context)
        .getById(entityId: widget.entityMini.id);
    ScopedModel.of<EntityModel>(context)
        .getWorkers(entityId: widget.entityMini.id);
    ScopedModel.of<EntityModel>(context)
        .getSeason(entityId: widget.entityMini.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<EntityModel>(
        builder: (context, child, entity) {
      return Scaffold(
          body: Stack(
        children: [
          !entity.entityMiniIsNull
              ? ListView(
                  children: [
                    entity.entityMini.images.isNotEmpty
                        ? SizedBox(
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
                                }),
                          )
                        : Container(
                            color: Colors.purple[100],
                            height: 300,
                            child: const Center(
                              child: Icon(
                                Icons.image,
                                size: 100,
                              ),
                            )),
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
                          .typeEntities[ConvertToEnum.convertTypeEntityToValue(
                              typeEntity: entity.entityMini.typeEntity)]
                          .toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    //update evaluation
                    SizedBox(
                      height: 80,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Evaluation(
                              value: 1,
                              evaluation: entity.entitySaveMini != null
                                  ? entity.entitySaveMini!.evaluation!
                                  : 0),
                          Evaluation(
                              value: 2,
                              evaluation: entity.entitySaveMini != null
                                  ? entity.entitySaveMini!.evaluation!
                                  : 0),
                          Evaluation(
                              value: 3,
                              evaluation: entity.entitySaveMini != null
                                  ? entity.entitySaveMini!.evaluation!
                                  : 0),
                          Evaluation(
                              value: 4,
                              evaluation: entity.entitySaveMini != null
                                  ? entity.entitySaveMini!.evaluation!
                                  : 3),
                          Evaluation(
                              value: 5,
                              evaluation: entity.entitySaveMini != null
                                  ? entity.entitySaveMini!.evaluation!
                                  : 0),
                        ],
                      ),
                    ),
                    //*update evaluation

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

                    //categoty update
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: DropdownButton(
                        hint: entity.entitySaveMini == null
                            ? const Text('category')
                            : entity
                                .dropdownList[entity.entitySaveMini!.categoty!],
                        items: entity.dropdownList,
                        onChanged: (value) {},
                      ),
                    ),
                    //*categoty update

                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //review update
                        ElevatedButton(
                            onPressed: () {}, child: const Text('add review')),
                        //*review update

                        const SizedBox(
                          width: 4.0,
                        ),

                        //goal update
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.add_task)),
                        //*goal update
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: entity.seasons.length + 1,
                          itemBuilder: (context, index) {
                            if (index == entity.seasons.length) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewSeasonEntity(
                                              entityMini: entity.entityMini,
                                              context: context)),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xffce93d8)),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    width: 150,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(Icons.add_box_outlined),
                                        Text('add season'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return SeasonMiniEntity(
                                seasonMini: entity.seasons[index],
                              );
                            }
                          }),
                    ),

                    const SizedBox(
                      height: 16.0,
                    ),

                    entity.entityMini.description != null
                        ? ExpansionTile(
                            onExpansionChanged: (_) {
                              entity.updateMaxLine();
                            },
                            title: Text(
                              entity.entityMini.description!,
                              maxLines: entity.maxLine,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                            ),
                          )
                        : Container(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateEntity(
                                          context: context,
                                          entityMini: entity.entityMini,
                                        )));
                          },
                          child: Text('edit ' +
                              LanguageModel()
                                  .typeEntities[
                                      ConvertToEnum.convertTypeEntityToValue(
                                          typeEntity:
                                              entity.entityMini.typeEntity)]
                                  .toString()
                                  .toLowerCase())),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: entity.workers.length + 1,
                          itemBuilder: (context, index) {
                            if (index == entity.workers.length) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewWorkerEntity(
                                            entityMini: entity.entityMini,
                                            context: context),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xffce93d8)),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    width: 150,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.add_box_outlined),
                                          Text('add worker'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return WorkerMiniEntity(
                                workerMini: entity.workers[index],
                                idUser: entity.idUser,
                              );
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 16.0,
                    )
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
    });
  }
}
