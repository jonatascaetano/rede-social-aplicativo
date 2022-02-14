import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/entity_save_dto.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/scoped_model/episode_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/mini_episodes/evaluation.dart';

import 'episode/update_episode.dart';
import 'episode/update_review_episode.dart';

// ignore: must_be_immutable
class Episode extends StatefulWidget {
  EpisodeMini episodeMini;
  Episode({required this.episodeMini, Key? key}) : super(key: key);

  @override
  _EpisodeState createState() => _EpisodeState();
}

class _EpisodeState extends State<Episode> {
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
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<EpisodeModel>(
          builder: (context, child, episode) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: !episode.episodeMiniIsNull
                  ? Text(
                      episode.episodeMini.name,
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
              // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              padding: EdgeInsets.zero,
              child: Stack(
                children: [
                  !episode.episodeMiniIsNull
                      ? ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            episode.episodeMini.image != null
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
                                            episode.episodeMini.image!),
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
                              episode.episodeMini.name,
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
                              'Episode ' +
                                  episode.episodeMini.numberEpisode.toString(),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 1.0,
                                color: theme.subtitle,
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              episode.episodeMini.season.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 1.0,
                                color: theme.subtitle,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              episode.episodeMini.season.entity.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 1.0,
                                color: theme.subtitle,
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: theme.button,
                                  elevation: 0.0,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateEpisode(
                                          episodeMini: episode.episodeMini,
                                          context: context),
                                    ),
                                  );
                                  // if (ScopedModel.of<ProfileModel>(context)
                                  //     .userMini
                                  //     .checked) {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => UpdateEpisode(
                                  //           episodeMini: episode.episodeMini,
                                  //           context: context),
                                  //     ),
                                  //   );
                                  // } else {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //       const SnackBar(
                                  //           content: Text(
                                  //               'only released to verified users')));
                                  // }
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
                                      'edit episode'.toLowerCase(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 1.0,
                                        color: theme.buttonText,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //update evaluation
                            episode.entitySaveMini == null
                                ? Container()
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Evaluation(
                                          value: 1,
                                          evaluation:
                                              episode.entitySaveMini != null
                                                  ? episode.entitySaveMini!
                                                      .evaluation!
                                                  : 0),
                                      Evaluation(
                                          value: 2,
                                          evaluation:
                                              episode.entitySaveMini != null
                                                  ? episode.entitySaveMini!
                                                      .evaluation!
                                                  : 0),
                                      Evaluation(
                                          value: 3,
                                          evaluation:
                                              episode.entitySaveMini != null
                                                  ? episode.entitySaveMini!
                                                      .evaluation!
                                                  : 0),
                                      Evaluation(
                                          value: 4,
                                          evaluation:
                                              episode.entitySaveMini != null
                                                  ? episode.entitySaveMini!
                                                      .evaluation!
                                                  : 3),
                                      Evaluation(
                                          value: 5,
                                          evaluation:
                                              episode.entitySaveMini != null
                                                  ? episode.entitySaveMini!
                                                      .evaluation!
                                                  : 0),
                                    ],
                                  ),
                            //*update evaluation

                            //*update evaluation
                            episode.entitySaveMini == null
                                ? Container()
                                : const SizedBox(
                                    height: 16.0,
                                  ),
                            //*update evaluation

                            Text(
                              episode.episodeMini.evaluationAverage
                                  .toStringAsPrecision(2),
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
                                  episode.episodeMini.evaluationQuantity
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
                                    level: null,
                                    spoiler: false,
                                  );
                                  if (episode.entitySaveMini == null) {
                                    episode.newEntitySave(
                                        entitySaveDTO: entitySaveDTO,
                                        context: context);
                                  } else {
                                    if (value !=
                                        episode.entitySaveMini!.category!) {
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
                            episode.entitySaveMini == null
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
                                          if (episode.entitySaveMini != null &&
                                              episode
                                                  .entitySaveMini!.reviewed) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateReviewEpisode(
                                                            review: episode
                                                                .entitySaveMini!
                                                                .review!)));
                                          } else if (episode.entitySaveMini !=
                                              null) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateReviewEpisode(
                                                            review: '')));
                                          }
                                        },
                                        child: episode.entitySaveMini != null
                                            ? episode.entitySaveMini!.reviewed
                                                ? Text(
                                                    'update review',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      letterSpacing: 1.0,
                                                      color:
                                                          theme.buttonMainText,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  )
                                                : Text(
                                                    'add review',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      letterSpacing: 1.0,
                                                      color:
                                                          theme.buttonMainText,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  )
                                            : Text(
                                                'add review',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  letterSpacing: 1.0,
                                                  color: theme.buttonMainText,
                                                  fontWeight: FontWeight.normal,
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
                            // const SizedBox(
                            //   height: 8.0,
                            // ),

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

                            const SizedBox(
                              height: 16.0,
                            ),

                            getBanner(AdmobBannerSize.MEDIUM_RECTANGLE),

                            const SizedBox(
                              height: 16.0,
                            ),

                            episode.episodeMini.description != null
                                ? ExpansionTile(
                                    onExpansionChanged: (_) {
                                      episode.updateMaxLine();
                                    },
                                    title: Text(
                                      episode.episodeMini.description!,
                                      maxLines: episode.maxLine,
                                      style: TextStyle(
                                        fontSize: 16,
                                        letterSpacing: 1.0,
                                        color: theme.title,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  )
                                : Container(),
                            const SizedBox(
                              height: 8.0,
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
              ),
            ));
      });
    });
  }
}
