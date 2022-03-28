// import 'package:flutter/material.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:social_network_application/entities/dto/season_dto.dart';
// import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
// import 'package:social_network_application/scoped_model/new_season_model.dart';
// import 'package:social_network_application/scoped_model/support/theme_model.dart';

// // ignore: must_be_immutable
// class NewSeasonEntity extends StatefulWidget {
//   EntityMini entityMini;
//   BuildContext context;
//   NewSeasonEntity({required this.entityMini, required this.context, Key? key}) : super(key: key);

//   @override
//   _NewSeasonEntityState createState() => _NewSeasonEntityState();
// }

// class _NewSeasonEntityState extends State<NewSeasonEntity> {
//   TextEditingController name = TextEditingController();
//   TextEditingController description = TextEditingController();
//   TextEditingController numberSeason = TextEditingController();
//   final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
//       return ScopedModel<NewSeasonModel>(
//           model: NewSeasonModel(),
//           child: ScopedModelDescendant<NewSeasonModel>(builder: (context, child, season) {
//             return Form(
//               key: _globalKey,
//               child: Scaffold(
//                 appBar: AppBar(
//                   elevation: 0.0,
//                   title: Text(
//                     "New season",
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
//                           //       return 'enter season number';
//                           //     }
//                           //   },
//                           //   controller: numberSeason,
//                           //   keyboardType: TextInputType.number,
//                           //   minLines: 1,
//                           //   maxLines: 10,
//                           //   decoration: const InputDecoration(
//                           //     label: Text("season number"),
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
//                                 SeasonDTO seasonDTO = SeasonDTO(
//                                   name: name.text,
//                                   description: description.text,
//                                   //numberSeason: int.parse(numberSeason.text),
//                                 );
//                                 season.createSeason(
//                                   seasonDTO: seasonDTO,
//                                   idEntity: widget.entityMini.id,
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
//                     season.load
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
