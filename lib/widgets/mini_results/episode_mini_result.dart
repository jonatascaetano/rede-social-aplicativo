import 'package:flutter/material.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
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
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Episode(episodeMini: widget.episodeMini)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            widget.episodeMini.image != null
                ? CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.episodeMini.image.toString()),
                    radius: 30.0,
                  )
                : CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: const Icon(Icons.image),
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
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  LanguageModel().typeObject[3],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
