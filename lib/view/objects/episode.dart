import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/entity_save_dto.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/scoped_model/episode_model.dart';
import 'package:social_network_application/view/episode/update_episode.dart';
import 'package:social_network_application/view/episode/update_review_entity.dart';
import 'package:social_network_application/widgets/mini_episodes/evaluation.dart';

// ignore: must_be_immutable
class Episode extends StatefulWidget {
  EpisodeMini episodeMini;
  Episode({required this.episodeMini, Key? key}) : super(key: key);

  @override
  _EpisodeState createState() => _EpisodeState();
}

class _EpisodeState extends State<Episode> {
  @override
  void initState() {
    ScopedModel.of<EpisodeModel>(context).episodeMiniIsNull = true;
    ScopedModel.of<EpisodeModel>(context).dropdownList = [];
    ScopedModel.of<EpisodeModel>(context).entitySaveMini = null;
    //ScopedModel.of<SeasonModel>(context).getId();
    ScopedModel.of<EpisodeModel>(context).getId();
    ScopedModel.of<EpisodeModel>(context)
        .getEpisode(episodeId: widget.episodeMini.id);
    ScopedModel.of<EpisodeModel>(context)
        .getEntitySave(episodeId: widget.episodeMini.id);
    // ScopedModel.of<SeasonModel>(context)
    //     .getWorkers(entityId: widget.entityMini.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<EpisodeModel>(
        builder: (context, child, episode) {
      return Scaffold(
          body: Stack(
        children: [
          !episode.episodeMiniIsNull
              ? ListView(
                  children: [
                    episode.episodeMini.image != null
                        ? Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(episode.episodeMini.image!),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
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
                      episode.episodeMini.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 28,
                        letterSpacing: 2.0,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      episode.episodeMini.season.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 18,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      episode.episodeMini.season.entity.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 18,
                        letterSpacing: 2.0,
                      ),
                    ),

                    //update evaluation
                    SizedBox(
                      height: 80,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Evaluation(
                              value: 1,
                              evaluation: episode.entitySaveMini != null
                                  ? episode.entitySaveMini!.evaluation!
                                  : 0),
                          Evaluation(
                              value: 2,
                              evaluation: episode.entitySaveMini != null
                                  ? episode.entitySaveMini!.evaluation!
                                  : 0),
                          Evaluation(
                              value: 3,
                              evaluation: episode.entitySaveMini != null
                                  ? episode.entitySaveMini!.evaluation!
                                  : 0),
                          Evaluation(
                              value: 4,
                              evaluation: episode.entitySaveMini != null
                                  ? episode.entitySaveMini!.evaluation!
                                  : 3),
                          Evaluation(
                              value: 5,
                              evaluation: episode.entitySaveMini != null
                                  ? episode.entitySaveMini!.evaluation!
                                  : 0),
                        ],
                      ),
                    ),
                    //*update evaluation

                    Text(
                      episode.episodeMini.evaluationAverage.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        letterSpacing: 2.0,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      '( ' +
                          episode.episodeMini.evaluationQuantity.toString() +
                          ' evaluations)',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),

                    //categoty update

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: DropdownButton<int>(
                        hint: episode.entitySaveMini == null
                            ? const Text('category')
                            : episode.dropdownList[
                                episode.entitySaveMini!.category! - 1],
                        items: episode.dropdownList,
                        onChanged: (value) {
                          // ignore: avoid_print
                          EntitySaveDTO entitySaveDTO = EntitySaveDTO(
                            idEntitySave: null,
                            idUser: episode.idUser,
                            idEntity: null,
                            idSeason: null,
                            idEpisode: episode.episodeMini.id,
                            category: value!,
                            goal: null,
                            rated: null,
                            reviewed: null,
                            evaluation: null,
                            review: null,
                            typeEntitySave: null,
                          );
                          if (episode.entitySaveMini == null) {
                            episode.newEntitySave(
                                entitySaveDTO: entitySaveDTO, context: context);
                          } else {
                            if (value != episode.entitySaveMini!.category!) {
                              entitySaveDTO.idEntitySave =
                                  episode.entitySaveMini!.id;
                              episode.updateCategoryEntitySave(
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
                            if (episode.entitySaveMini != null &&
                                episode.entitySaveMini!.reviewed) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateReviewEpisode(
                                          review: episode
                                              .entitySaveMini!.review!)));
                            } else if (episode.entitySaveMini != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateReviewEpisode(review: '')));
                            }
                          },
                          child: episode.entitySaveMini != null
                              ? episode.entitySaveMini!.reviewed
                                  ? const Text(
                                      'update review',
                                      style: TextStyle(
                                        fontSize: 14,
                                        letterSpacing: 1.0,
                                      ),
                                    )
                                  : const Text(
                                      'add review',
                                      style: TextStyle(
                                        fontSize: 14,
                                        letterSpacing: 1.0,
                                      ),
                                    )
                              : const Text(
                                  'add review',
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                        ),
                        //*review update

                        // const SizedBox(
                        //   width: 4.0,
                        // ),

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

                    // SizedBox(
                    //   height: 200,
                    //   child: ListView.builder(
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: season.episodes.length + 1,
                    //       itemBuilder: (context, index) {
                    //         if (index == season.episodes.length) {
                    //           return Padding(
                    //             padding: const EdgeInsets.all(4.0),
                    //             child: GestureDetector(
                    //               onTap: () {
                    //                 Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) =>
                    //                           NewEpisodeSeason(
                    //                               seasonMini: season.seasonMini,
                    //                               context: context)),
                    //                 );
                    //               },
                    //               child: Container(
                    //                 decoration: BoxDecoration(
                    //                   border: Border.all(
                    //                       color: const Color(0xffce93d8)),
                    //                   borderRadius: BorderRadius.circular(8.0),
                    //                 ),
                    //                 width: 150,
                    //                 child: Column(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.center,
                    //                   children: const [
                    //                     Icon(Icons.add_box_outlined),
                    //                     Text('add episode'),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           );
                    //         } else {
                    //           return EpisodeMiniSeason(
                    //               episodeMini: season.episodes[index]);
                    //         }
                    //       }),
                    // ),

                    // const SizedBox(
                    //   height: 16.0,
                    // ),

                    episode.episodeMini.description != null
                        ? ExpansionTile(
                            onExpansionChanged: (_) {
                              episode.updateMaxLine();
                            },
                            title: Text(
                              episode.episodeMini.description!,
                              maxLines: episode.maxLine,
                              style: TextStyle(
                                fontSize: 18,
                                letterSpacing: 1.0,
                                color: Colors.grey[700],
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
                              builder: (context) => UpdateEpisode(
                                  episodeMini: episode.episodeMini,
                                  context: context),
                            ),
                          );
                        },
                        child: Text(
                          'edit episode'.toLowerCase(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
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
                    // const SizedBox(
                    //   height: 16.0,
                    // )
                  ],
                )
              : Container(),
          episode.load
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
