import 'package:flutter/material.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/view/objects/episode.dart';

// ignore: must_be_immutable
class EpisodeMiniSeason extends StatefulWidget {
  EpisodeMini episodeMini;
  EpisodeMiniSeason({required this.episodeMini, Key? key}) : super(key: key);

  @override
  _EpisodeMiniSeasonState createState() => _EpisodeMiniSeasonState();
}

class _EpisodeMiniSeasonState extends State<EpisodeMiniSeason> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 150.0,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffe1bee7)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  children: [
                    widget.episodeMini.image != null
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.episodeMini.image!),
                            radius: 30.0,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: const Icon(
                              Icons.image,
                              size: 30.0,
                            ),
                            radius: 30.0,
                          ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      widget.episodeMini.name,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      style: const TextStyle(
                        fontSize: 18.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    // Text(
                    //   'Episodes ' + widget.episodeMini.episodeQuantity.toString(),
                    //   textAlign: TextAlign.center,
                    //   style: const TextStyle(
                    //     fontSize: 13.0,
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 4.0,
                    // ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 1.0,
                  primary: Colors.purple.shade200,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Episode(episodeMini: widget.episodeMini),
                    ),
                  );
                },
                child: const Text(
                  "view",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
