import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/converts/convert_to_enum.dart';
import 'package:social_network_application/entities/dto/entity_save_dto.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/scoped_model/entity_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/entity/all_seasons_entity.dart';
import 'package:social_network_application/view/entity/all_workers_entity.dart';
import 'package:social_network_application/view/entity/new_season_entity.dart';
import 'package:social_network_application/view/entity/new_worker_entity.dart';
import 'package:social_network_application/view/entity/update_entity.dart';
import 'package:social_network_application/view/entity/update_review_entity.dart';
import 'package:social_network_application/widgets/mini_entities/evaluation.dart';
import 'package:social_network_application/widgets/mini_entities/season_mini_entity.dart';
import 'package:social_network_application/widgets/mini_entities/worker_mini_entity.dart';

// ignore: must_be_immutable
class Entity extends StatefulWidget {
  EntityMini entityMini;
  bool datasheetIsOpen;
  Entity({required this.entityMini, required this.datasheetIsOpen, Key? key})
      : super(key: key);

  @override
  _EntityState createState() => _EntityState();
}

class _EntityState extends State<Entity> {
  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        // ignore: avoid_print
        print('Novo $adType Ad carregado!');
        break;
      case AdmobAdEvent.opened:
        // ignore: avoid_print
        print('Admob $adType Ad aberto!');
        break;
      case AdmobAdEvent.closed:
        // ignore: avoid_print
        print('Admob $adType Ad fechado!');
        break;
      case AdmobAdEvent.failedToLoad:
        // ignore: avoid_print
        print('Admob $adType falhou ao carregar. :(');
        break;
      default:
    }
  }

  AdmobBanner getBanner(AdmobBannerSize size) {
    return AdmobBanner(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      adSize: size,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        handleEvent(event, args!, 'Banner');
      },
    );
  }

  @override
  void initState() {
    ScopedModel.of<EntityModel>(context).entityMiniIsNull = true;
    ScopedModel.of<EntityModel>(context).dropdownList = [];
    ScopedModel.of<EntityModel>(context).entitySaveMini = null;
    ScopedModel.of<EntityModel>(context).getId();
    ScopedModel.of<EntityModel>(context)
        .getEntity(entityId: widget.entityMini.id);
    ScopedModel.of<EntityModel>(context)
        .getEntitySave(entityId: widget.entityMini.id);
    ScopedModel.of<EntityModel>(context)
        .getWorkers(entityId: widget.entityMini.id);
    ScopedModel.of<EntityModel>(context)
        .getSeason(entityId: widget.entityMini.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<EntityModel>(
          builder: (context, child, entity) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: !entity.entityMiniIsNull
                  ? Text(
                      entity.entityMini.name,
                      style: TextStyle(
                        color: theme.title,
                        fontSize: 24.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  : const Text(''),
            ),
            body: Container(
              //margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              padding: EdgeInsets.zero,
              child: Stack(
                children: [
                  !entity.entityMiniIsNull
                      ? ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            entity.entityMini.image != null
                                ? Container(
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.zero,
                                    height: (MediaQuery.of(context).size.width /
                                            16) *
                                        9,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: theme.shadow,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            entity.entityMini.image!),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  )
                                : Container(
                                    color: theme.shadow,
                                    height: (MediaQuery.of(context).size.width /
                                            16) *
                                        9,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Icon(
                                        Icons.image,
                                        size: 100,
                                        color: theme.emphasis,
                                      ),
                                    )),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              entity.entityMini.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 21,
                                color: theme.title,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              LanguageModel()
                                  .typeEntities[
                                      ConvertToEnum.convertTypeEntityToValue(
                                          typeEntity:
                                              entity.entityMini.typeEntity)]
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 1.0,
                                color: theme.subtitle,
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                            const SizedBox(
                              height: 16.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: theme.button,
                                  elevation: 0.0,
                                ),
                                onPressed: () {
                                  if (ScopedModel.of<ProfileModel>(context)
                                      .userMini
                                      .checked) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UpdateEntity(
                                                  context: context,
                                                  entityMini: entity.entityMini,
                                                )));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'only released to verified users')));
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.edit,
                                      color: theme.buttonMain,
                                    ),
                                    const SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      'edit ' +
                                          LanguageModel()
                                              .typeEntities[ConvertToEnum
                                                  .convertTypeEntityToValue(
                                                      typeEntity: entity
                                                          .entityMini
                                                          .typeEntity)]
                                              .toString()
                                              .toLowerCase(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 1.0,
                                        color: theme.buttonText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //update evaluation
                            entity.entitySaveMini == null
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.zero,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Evaluation(
                                            value: 1,
                                            evaluation:
                                                entity.entitySaveMini != null
                                                    ? entity.entitySaveMini!
                                                        .evaluation!
                                                    : 0),
                                        Evaluation(
                                            value: 2,
                                            evaluation:
                                                entity.entitySaveMini != null
                                                    ? entity.entitySaveMini!
                                                        .evaluation!
                                                    : 0),
                                        Evaluation(
                                            value: 3,
                                            evaluation:
                                                entity.entitySaveMini != null
                                                    ? entity.entitySaveMini!
                                                        .evaluation!
                                                    : 0),
                                        Evaluation(
                                            value: 4,
                                            evaluation:
                                                entity.entitySaveMini != null
                                                    ? entity.entitySaveMini!
                                                        .evaluation!
                                                    : 3),
                                        Evaluation(
                                            value: 5,
                                            evaluation:
                                                entity.entitySaveMini != null
                                                    ? entity.entitySaveMini!
                                                        .evaluation!
                                                    : 0),
                                      ],
                                    ),
                                  ),
                            //*update evaluation
                            entity.entitySaveMini == null
                                ? Container()
                                : const SizedBox(
                                    height: 16.0,
                                  ),

                            Text(
                              entity.entityMini.evaluationAverage.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                letterSpacing: 1.0,
                                color: theme.emphasis,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              '( ' +
                                  entity.entityMini.evaluationQuantity
                                      .toString() +
                                  ' evaluations)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 1.0,
                                color: theme.title,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),

                            //categoty update
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: DropdownButton<int>(
                                dropdownColor: theme.background,
                                // style: const TextStyle(
                                //   fontSize: 18,
                                //   letterSpacing: 2.0,
                                // ),
                                hint: entity.entitySaveMini == null
                                    ? const Text(
                                        'category',
                                      )
                                    : entity.dropdownList[
                                        entity.entitySaveMini!.category! - 1],
                                items: entity.dropdownList,
                                onChanged: (value) {
                                  // ignore: avoid_print
                                  EntitySaveDTO entitySaveDTO = EntitySaveDTO(
                                    idEntitySave: null,
                                    idUser: entity.idUser,
                                    idEntity: entity.entityMini.id,
                                    idSeason: null,
                                    idEpisode: null,
                                    category: value!,
                                    goal: null,
                                    rated: null,
                                    reviewed: null,
                                    evaluation: null,
                                    review: null,
                                    level: null,
                                    spoiler: false,
                                  );
                                  if (entity.entitySaveMini == null) {
                                    entity.newEntitySave(
                                        entitySaveDTO: entitySaveDTO,
                                        context: context);
                                  } else {
                                    if (value !=
                                        entity.entitySaveMini!.category!) {
                                      entitySaveDTO.idEntitySave =
                                          entity.entitySaveMini!.id;
                                      entity.updateCategoryEntitySave(
                                          entitySaveDTO: entitySaveDTO,
                                          context: context);
                                    }
                                  }
                                },
                              ),
                            ),
                            //*categoty update

                            const SizedBox(
                              height: 8.0,
                            ),
                            entity.entitySaveMini == null
                                ? Container()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      //review update
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: theme.buttonMain,
                                          elevation: 1.0,
                                        ),
                                        onPressed: () {
                                          if (entity.entitySaveMini != null &&
                                              entity.entitySaveMini!.reviewed) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateReviewEntity(
                                                            review: entity
                                                                .entitySaveMini!
                                                                .review!)));
                                          } else if (entity.entitySaveMini !=
                                              null) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateReviewEntity(
                                                            review: '')));
                                          }
                                        },
                                        child: entity.entitySaveMini != null
                                            ? entity.entitySaveMini!.reviewed
                                                ? Text(
                                                    'update review',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      letterSpacing: 1.0,
                                                      color:
                                                          theme.buttonMainText,
                                                    ),
                                                  )
                                                : Text(
                                                    'add review',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      letterSpacing: 1.0,
                                                      color:
                                                          theme.buttonMainText,
                                                    ),
                                                  )
                                            : Text(
                                                'add review',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  letterSpacing: 1.0,
                                                  color: theme.buttonMainText,
                                                ),
                                              ),
                                      ),
                                      //*review update

                                      const SizedBox(
                                        width: 4.0,
                                      ),

                                      //goal update
                                      IconButton(
                                        onPressed: () {
                                          if (entity.entitySaveMini != null) {
                                            EntitySaveDTO entitySaveDTO =
                                                EntitySaveDTO(
                                              idEntitySave:
                                                  entity.entitySaveMini!.id,
                                              idUser: entity.idUser,
                                              idEntity: entity.entityMini.id,
                                              idSeason: null,
                                              idEpisode: null,
                                              category: null,
                                              goal:
                                                  !entity.entitySaveMini!.goal,
                                              rated: null,
                                              reviewed: null,
                                              evaluation: null,
                                              review: null,
                                              level: null,
                                              spoiler: false,
                                            );
                                            entity.updateGoalEntitySave(
                                                entitySaveDTO: entitySaveDTO,
                                                context: context);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.add_task,
                                          size: 30.0,
                                          color: entity.entitySaveMini != null
                                              ? entity.entitySaveMini!.goal
                                                  ? theme.emphasis
                                                  : theme.button
                                              : theme.button,
                                        ),
                                      ),
                                      //*goal update
                                    ],
                                  ),
                            const SizedBox(
                              height: 16.0,
                            ),

                            getBanner(AdmobBannerSize.MEDIUM_RECTANGLE),

                            const SizedBox(
                              height: 16.0,
                            ),

                            entity.entityMini.description != null
                                ? ExpansionTile(
                                    tilePadding: const EdgeInsets.all(8.0),
                                    onExpansionChanged: (_) {
                                      entity.updateMaxLine();
                                    },
                                    title: Text(
                                      entity.entityMini.description!,
                                      maxLines: entity.maxLine,
                                      style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 1.0,
                                        color: theme.title,
                                      ),
                                    ),
                                  )
                                : Container(),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'View all seasons',
                                      style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 1.0,
                                        color: theme.subtitle,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AllSeasonsEntity(),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                      color: theme.subtitle,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 280,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: entity.seasons.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == entity.seasons.length) {
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (ScopedModel.of<ProfileModel>(
                                                    context)
                                                .userMini
                                                .checked) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NewSeasonEntity(
                                                            entityMini: entity
                                                                .entityMini,
                                                            context: context)),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'only released to verified users')));
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: theme.shadow,
                                              border: Border.all(
                                                color: theme.shadow,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            width: 200,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add_box_outlined,
                                                    color: theme.emphasis),
                                                Text(
                                                  'add season',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    letterSpacing: 1.0,
                                                    color: theme.title,
                                                  ),
                                                ),
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

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'View all cast',
                                      style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 1.0,
                                        color: theme.subtitle,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AllWorkersEntity(),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                      color: theme.subtitle,
                                      size: 24.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 260,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: entity.workers.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == entity.workers.length) {
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (ScopedModel.of<ProfileModel>(
                                                    context)
                                                .userMini
                                                .checked) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewWorkerEntity(
                                                          entityMini:
                                                              entity.entityMini,
                                                          context: context),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'only released to verified users')));
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: theme.shadow,
                                              border: Border.all(
                                                color: theme.shadow,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            width: 200,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.add_box_outlined,
                                                    color: theme.emphasis,
                                                  ),
                                                  Text(
                                                    'add worker',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      letterSpacing: 1.0,
                                                      color: theme.title,
                                                    ),
                                                  ),
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
              ),
            ));
      });
    });
  }
}
