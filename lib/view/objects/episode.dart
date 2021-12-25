import 'package:flutter/material.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';

// ignore: must_be_immutable
class Episode extends StatefulWidget {
  EpisodeMini episodeMini;
  Episode({required this.episodeMini, Key? key}) : super(key: key);

  @override
  _EpisodeState createState() => _EpisodeState();
}

class _EpisodeState extends State<Episode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Episode'),
            Text(widget.episodeMini.name),
          ],
        ),
      ),
    );
  }
}
