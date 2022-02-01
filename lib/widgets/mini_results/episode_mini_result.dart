import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/objects/episode.dart';

// ignore: must_be_immutable
class EpisodeMiniResult extends StatefulWidget {
  EpisodeMini episodeMini;
  EpisodeMiniResult({required this.episodeMini, Key? key}) : super(key: key);

  @override
  _EpisodeMiniResultState createState() => _EpisodeMiniResultState();
}

class _EpisodeMiniResultState extends State<EpisodeMiniResult> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Episode(episodeMini: widget.episodeMini)));
        },
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            child: Row(
              children: [
                widget.episodeMini.image != null
                    ? CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.episodeMini.image!),
                        radius: 30.0,
                      )
                    : CircleAvatar(
                        backgroundColor: theme.shadow,
                        child: Icon(
                          Icons.image,
                          color: theme.emphasis,
                        ),
                        radius: 30.0,
                      ),
                const SizedBox(
                  width: 8.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200.0,
                      child: Text(
                        widget.episodeMini.name,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.title,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    // Text(
                    //   LanguageModel().typeObject[3],
                    //   style: const TextStyle(
                    //     fontSize: 16,
                    //   ),
                    // ),
                    const SizedBox(
                      width: 2.0,
                    ),
                    Text(
                      widget.episodeMini.season.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.subtitle,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      width: 2.0,
                    ),
                    Text(
                      widget.episodeMini.season.entity.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.subtitle,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
