import 'package:flutter/material.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';

// ignore: must_be_immutable
class UpdateEpisode extends StatefulWidget {
  EpisodeMini episodeMini;
  BuildContext context;
  UpdateEpisode({required this.episodeMini, required this.context, Key? key})
      : super(key: key);

  @override
  _UpdateEpisodeState createState() => _UpdateEpisodeState();
}

class _UpdateEpisodeState extends State<UpdateEpisode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.episodeMini.name),
      ),
    );
  }
}
