// import 'package:flutter/material.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
// import 'package:social_network_application/scoped_model/episode_mini_season_model.dart';
// import 'package:social_network_application/scoped_model/support/theme_model.dart';
// import 'package:social_network_application/view/objects/episode.dart';

// // ignore: must_be_immutable
// class EpisodeMiniSeason extends StatefulWidget {
//   EpisodeMini episodeMini;
//   EpisodeMiniSeason({required this.episodeMini, Key? key}) : super(key: key);

//   @override
//   _EpisodeMiniSeasonState createState() => _EpisodeMiniSeasonState();
// }

// class _EpisodeMiniSeasonState extends State<EpisodeMiniSeason> {
//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
//       return ScopedModel<EpisodeMiniSeasonModel>(
//           model: EpisodeMiniSeasonModel(episodeId: widget.episodeMini.id),
//           child: ScopedModelDescendant<EpisodeMiniSeasonModel>(builder: (context, child, episodeMiniSeason) {
//             return Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: Container(
//                 width: 200.0,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: theme.shadow),
//                   //borderRadius: BorderRadius.circular(8.0),
//                   borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         children: [
//                           widget.episodeMini.image != null
//                               ? Container(
//                                   height: 150,
//                                   width: 200,
//                                   decoration: BoxDecoration(
//                                     color: theme.shadow,
//                                     borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
//                                     image: DecorationImage(
//                                       image: NetworkImage(widget.episodeMini.image!),
//                                       fit: BoxFit.fitHeight,
//                                     ),
//                                   ),
//                                 )
//                               : Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
//                                     color: theme.shadow,
//                                   ),
//                                   height: 150,
//                                   width: 200,
//                                   child: Center(
//                                     child: Icon(
//                                       Icons.image,
//                                       color: theme.emphasis,
//                                       size: 150,
//                                     ),
//                                   ),
//                                 ),
//                           const SizedBox(
//                             height: 8.0,
//                           ),
//                           Text(
//                             widget.episodeMini.name,
//                             textAlign: TextAlign.center,
//                             overflow: TextOverflow.fade,
//                             maxLines: 1,
//                             softWrap: false,
//                             style: TextStyle(
//                               color: theme.title,
//                               fontSize: theme.sizeTitle,
//                               letterSpacing: theme.letterSpacingTitle,
//                               fontWeight: FontWeight.normal,
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 4.0,
//                           ),
//                           // episodeMiniSeason.entitySaveMiniIsNull
//                           //     ? Center(
//                           //         child: Icon(
//                           //           Icons.highlight_remove_sharp,
//                           //           color: theme.detail,
//                           //         ),
//                           //       )
//                           //     : Center(
//                           //         child: Icon(
//                           //           Icons.check_circle_outline,
//                           //           color: theme.emphasis,
//                           //         ),
//                           //       )
//                           // Text(
//                           //     LanguageModel().entitiesCategories[
//                           //         ConvertToEnum.convertTypeEntityToValue(
//                           //             typeEntity: widget.episodeMini.season
//                           //                 .entity.typeEntity)][1],
//                           //     textAlign: TextAlign.center,
//                           //     style: TextStyle(
//                           //       color: theme.emphasis,
//                           //     ),
//                           //   ),

//                           // Text(
//                           //   'Episodes ' + widget.episodeMini.episodeQuantity.toString(),
//                           //   textAlign: TextAlign.center,
//                           //   style: const TextStyle(
//                           //     fontSize: 13.0,
//                           //   ),
//                           // ),
//                           // const SizedBox(
//                           //   height: 4.0,
//                           // ),
//                         ],
//                       ),
//                     ),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         elevation: 1.0,
//                         primary: theme.buttonMain,
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => Episode(episodeMini: widget.episodeMini),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         "view",
//                         style: TextStyle(
//                           color: theme.buttonMainText,
//                           fontSize: theme.sizeButton,
//                           letterSpacing: theme.letterSpacingButton,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }));
//     });
//   }
// }
