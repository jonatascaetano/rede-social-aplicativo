// import 'package:flutter/material.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:social_network_application/entities/mini_dto/season_mini.dart';
// import 'package:social_network_application/scoped_model/support/theme_model.dart';
// import 'package:social_network_application/view/objects/season.dart';

// // ignore: must_be_immutable
// class SeasonMiniResult extends StatefulWidget {
//   SeasonMini seasonMini;
//   SeasonMiniResult({required this.seasonMini, Key? key}) : super(key: key);

//   @override
//   _SeasonMiniResultState createState() => _SeasonMiniResultState();
// }

// class _SeasonMiniResultState extends State<SeasonMiniResult> {
//   @override
//   Widget build(BuildContext context) {
//     return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
//       return GestureDetector(
//         onTap: () {
//           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Season(seasonMini: widget.seasonMini)));
//         },
//         child: Container(
//           color: Colors.transparent,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 widget.seasonMini.image != null
//                     ? CircleAvatar(
//                         backgroundImage: NetworkImage(widget.seasonMini.image!),
//                         radius: 30.0,
//                       )
//                     : CircleAvatar(
//                         backgroundColor: theme.shadow,
//                         child: Icon(Icons.image, color: theme.emphasis),
//                         radius: 30.0,
//                       ),
//                 const SizedBox(
//                   width: 8.0,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: 200.0,
//                       child: Text(
//                         widget.seasonMini.name,
//                         overflow: TextOverflow.fade,
//                         maxLines: 1,
//                         softWrap: false,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: theme.title,
//                           letterSpacing: 1.0,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                     // Text(
//                     //   LanguageModel().typeObject[2],
//                     //   style: const TextStyle(
//                     //     fontSize: 16,
//                     //   ),
//                     // ),
//                     const SizedBox(
//                       width: 2.0,
//                     ),
//                     Text(
//                       widget.seasonMini.entity.name,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: theme.subtitle,
//                         letterSpacing: 1.0,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
