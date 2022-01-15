import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/entity_save_dto.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';
import 'package:social_network_application/scoped_model/season_model.dart';
import 'package:social_network_application/view/season/update_review_season.dart';
import 'package:social_network_application/widgets/mini_seasons/evaluation.dart';

// ignore: must_be_immutable
class Season extends StatefulWidget {
  SeasonMini seasonMini;
  Season({required this.seasonMini, Key? key}) : super(key: key);

  @override
  _SeasonState createState() => _SeasonState();
}

class _SeasonState extends State<Season> {
  @override
  void initState() {
    ScopedModel.of<SeasonModel>(context).seasonMiniIsNull = true;
    ScopedModel.of<SeasonModel>(context).dropdownList = [];
    ScopedModel.of<SeasonModel>(context).entitySaveMini = null;
    //ScopedModel.of<SeasonModel>(context).getId();
    ScopedModel.of<SeasonModel>(context).getId();
    ScopedModel.of<SeasonModel>(context)
        .getSeason(seasonId: widget.seasonMini.id);
    ScopedModel.of<SeasonModel>(context)
        .getEntitySave(seasonId: widget.seasonMini.id);
    // ScopedModel.of<SeasonModel>(context)
    //     .getWorkers(entityId: widget.entityMini.id);
    ScopedModel.of<SeasonModel>(context)
        .getEpisodes(seasonId: widget.seasonMini.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SeasonModel>(
        builder: (context, child, season) {
      return Scaffold(
          body: Stack(
        children: [
          !season.seasonMiniIsNull
              ? ListView(
                  children: [
                    season.seasonMini.images.isNotEmpty
                        ? SizedBox(
                            height: 300,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: season.seasonMini.images.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 300,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            season.seasonMini.images[index]),
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
                      season.seasonMini.name,
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
                      season.seasonMini.entity.name,
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
                              evaluation: season.entitySaveMini != null
                                  ? season.entitySaveMini!.evaluation!
                                  : 0),
                          Evaluation(
                              value: 2,
                              evaluation: season.entitySaveMini != null
                                  ? season.entitySaveMini!.evaluation!
                                  : 0),
                          Evaluation(
                              value: 3,
                              evaluation: season.entitySaveMini != null
                                  ? season.entitySaveMini!.evaluation!
                                  : 0),
                          Evaluation(
                              value: 4,
                              evaluation: season.entitySaveMini != null
                                  ? season.entitySaveMini!.evaluation!
                                  : 3),
                          Evaluation(
                              value: 5,
                              evaluation: season.entitySaveMini != null
                                  ? season.entitySaveMini!.evaluation!
                                  : 0),
                        ],
                      ),
                    ),
                    //*update evaluation

                    Text(
                      season.seasonMini.evaluationAverage.toString(),
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
                          season.seasonMini.evaluationQuantity.toString() +
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
                      child: DropdownButton<int>(
                        hint: season.entitySaveMini == null
                            ? const Text('category')
                            : season.dropdownList[
                                season.entitySaveMini!.category! - 1],
                        items: season.dropdownList,
                        onChanged: (value) {
                          // ignore: avoid_print
                          EntitySaveDTO entitySaveDTO = EntitySaveDTO(
                            idEntitySave: null,
                            idUser: season.idUser,
                            idEntity: null,
                            idSeason: season.seasonMini.id,
                            idEpisode: null,
                            category: value!,
                            goal: null,
                            rated: null,
                            reviewed: null,
                            evaluation: null,
                            review: null,
                            typeEntitySave: null,
                          );
                          if (season.entitySaveMini == null) {
                            season.newEntitySave(
                                entitySaveDTO: entitySaveDTO, context: context);
                          } else {
                            if (value != season.entitySaveMini!.category!) {
                              entitySaveDTO.idEntitySave =
                                  season.entitySaveMini!.id;
                              season.updateCategoryEntitySave(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //review update
                        ElevatedButton(
                          onPressed: () {
                            if (season.entitySaveMini != null &&
                                season.entitySaveMini!.reviewed) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateReviewSeason(
                                          review:
                                              season.entitySaveMini!.review!)));
                            } else if (season.entitySaveMini != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateReviewSeason(review: '')));
                            }
                          },
                          child: season.entitySaveMini != null
                              ? season.entitySaveMini!.reviewed
                                  ? const Text('update review')
                                  : const Text('add review')
                              : const Text('add review'),
                        ),
                        //*review update

                        const SizedBox(
                          width: 4.0,
                        ),

                        //goal update

                        // IconButton(
                        //   onPressed: () {
                        //     if (season.entitySaveMini != null) {
                        //       EntitySaveDTO entitySaveDTO = EntitySaveDTO(
                        //         idEntitySave: entity.entitySaveMini!.id,
                        //         idUser: entity.idUser,
                        //         idEntity: entity.entityMini.id,
                        //         idSeason: null,
                        //         idEpisode: null,
                        //         category: null,
                        //         goal: !entity.entitySaveMini!.goal,
                        //         rated: null,
                        //         reviewed: null,
                        //         evaluation: null,
                        //         review: null,
                        //         typeEntitySave: null,
                        //       );
                        //       entity.updateGoalEntitySave(
                        //           entitySaveDTO: entitySaveDTO,
                        //           context: context);
                        //     }
                        //   },
                        //   icon: Icon(
                        //     Icons.add_task,
                        //     color: season.entitySaveMini != null
                        //         ? season.entitySaveMini!.goal
                        //             ? Colors.purple
                        //             : Colors.grey
                        //         : Colors.grey,
                        //    ),
                        // ),

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
                          itemCount: season.episodes.length + 1,
                          itemBuilder: (context, index) {
                            if (index == season.episodes.length) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => NewSeasonEntity(
                                    //           entityMini: entity.entityMini,
                                    //           context: context)),
                                    // );
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
                                        Text('add episode'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                              // return SeasonMiniEntity(
                              //   seasonMini: entity.seasons[index],
                              // );
                            }
                          }),
                    ),

                    const SizedBox(
                      height: 16.0,
                    ),

                    season.seasonMini.description != null
                        ? ExpansionTile(
                            onExpansionChanged: (_) {
                              season.updateMaxLine();
                            },
                            title: Text(
                              season.seasonMini.description!,
                              maxLines: season.maxLine,
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
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => UpdateEntity(
                            //               context: context,
                            //               entityMini: entity.entityMini,
                            //             )));
                          },
                          child: Text('edit season'.toLowerCase())),
                    ),
                    // const SizedBox(
                    //   height: 16.0,
                    // ),
                    // SizedBox(
                    //   height: 150,
                    //   child: ListView.builder(
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: season.workers.length + 1,
                    //       itemBuilder: (context, index) {
                    //         if (index == season.workers.length) {
                    //           return Padding(
                    //             padding: const EdgeInsets.all(4.0),
                    //             child: GestureDetector(
                    //               onTap: () {
                    //                 // Navigator.push(
                    //                 //   context,
                    //                 //   MaterialPageRoute(
                    //                 //     builder: (context) => NewWorkerEntity(
                    //                 //         entityMini: entity.entityMini,
                    //                 //         context: context),
                    //                 //   ),
                    //                 // );
                    //               },
                    //               child: Container(
                    //                 decoration: BoxDecoration(
                    //                   border: Border.all(
                    //                       color: const Color(0xffce93d8)),
                    //                   borderRadius: BorderRadius.circular(8.0),
                    //                 ),
                    //                 width: 150,
                    //                 child: Center(
                    //                   child: Column(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.center,
                    //                     children: const [
                    //                       Icon(Icons.add_box_outlined),
                    //                       Text('add worker'),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           );
                    //         } else {
                    //           return Container();
                    //           return WorkerMiniEntity(
                    //             workerMini: entity.workers[index],
                    //             idUser: entity.idUser,
                    //           );
                    //         }
                    //       }),
                    // ),
                    const SizedBox(
                      height: 16.0,
                    )
                  ],
                )
              : Container(),
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
      ));
    });
  }
}
