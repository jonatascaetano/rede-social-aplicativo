// import 'package:flutter/material.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:social_network_application/entities/dto/episode_dto.dart';
// import 'package:social_network_application/entities/mini_dto/season_mini.dart';
// import 'package:social_network_application/scoped_model/new_episode_model.dart';
// import 'package:social_network_application/scoped_model/support/theme_model.dart';

// // ignore: must_be_immutable
// class NewEpisodeSeason extends StatefulWidget {
//   SeasonMini seasonMini;
//   BuildContext context;
//   NewEpisodeSeason({required this.seasonMini, required this.context, Key? key}) : super(key: key);

//   @override
//   _NewEpisodeSeasonState createState() => _NewEpisodeSeasonState();
// }

// class _NewEpisodeSeasonState extends State<NewEpisodeSeason> {
//   TextEditingController name = TextEditingController();
//   TextEditingController description = TextEditingController();
//   TextEditingController numberEpisode = TextEditingController();
//   final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
//       return ScopedModel<NewEpisodeModel>(
//           model: NewEpisodeModel(),
//           child: ScopedModelDescendant<NewEpisodeModel>(builder: (context, child, episode) {
//             return Form(
//               key: _globalKey,
//               child: Scaffold(
//                 appBar: AppBar(
//                   elevation: 0.0,
//                   title: Text(
//                     "New episode",
//                     style: TextStyle(
//                       color: theme.title,
//                       fontSize: theme.sizeAppBar,
//                       letterSpacing: theme.letterSpacingAppBar,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ),
//                 body: Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
//                       child: ListView(
//                         children: [
//                           TextFormField(
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'inform the name';
//                               }
//                             },
//                             controller: name,
//                             keyboardType: TextInputType.text,
//                             minLines: 1,
//                             maxLines: 10,
//                             decoration: const InputDecoration(
//                               label: Text("name"),
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 8.0,
//                           ),
//                           TextFormField(
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'inform the synopsis';
//                               }
//                             },
//                             controller: description,
//                             keyboardType: TextInputType.text,
//                             minLines: 10,
//                             maxLines: 10,
//                             decoration: const InputDecoration(
//                               label: Text("description"),
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 8.0,
//                           ),
//                           // TextFormField(
//                           //   validator: (value) {
//                           //     if (value!.isEmpty) {
//                           //       return 'enter episode number';
//                           //     }
//                           //   },
//                           //   controller: numberEpisode,
//                           //   keyboardType: TextInputType.number,
//                           //   minLines: 1,
//                           //   maxLines: 10,
//                           //   decoration: const InputDecoration(
//                           //     label: Text("episode number"),
//                           //     border: OutlineInputBorder(),
//                           //   ),
//                           // ),
//                           // const SizedBox(
//                           //   height: 8.0,
//                           // ),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               primary: theme.buttonMain,
//                               elevation: 0.0,
//                             ),
//                             onPressed: () {
//                               if (_globalKey.currentState!.validate()) {
//                                 EpisodeDTO episodeDTO = EpisodeDTO(
//                                   name: name.text,
//                                   description: description.text,
//                                   //numberEpisode: int.parse(numberEpisode.text),
//                                   idEpisode: '',
//                                 );
//                                 episode.createEpisode(
//                                   episodeDTO: episodeDTO,
//                                   idSeason: widget.seasonMini.id,
//                                   context: context,
//                                 );
//                               }
//                             },
//                             child: Text(
//                               "Confirm",
//                               style: TextStyle(
//                                 color: theme.buttonMainText,
//                                 fontSize: theme.sizeButton,
//                                 letterSpacing: theme.letterSpacingButton,
//                                 fontWeight: FontWeight.normal,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     episode.load
//                         ? Positioned(
//                             bottom: 0.1,
//                             child: SizedBox(
//                               height: 5.0,
//                               width: MediaQuery.of(context).size.width,
//                               child: const LinearProgressIndicator(),
//                             ),
//                           )
//                         : Container(),
//                   ],
//                 ),
//               ),
//             );
//           }));
//     });
//   }
// }
