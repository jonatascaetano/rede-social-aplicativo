import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/episode_mini.dart';
import 'package:social_network_application/scoped_model/episode_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

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
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<EpisodeModel>(
          builder: (context, child, episode) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              'Update ' + widget.episodeMini.name,
              style: TextStyle(
                color: theme.title,
                fontSize: 24.0,
                letterSpacing: 1.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: const [],
                ),
              ),
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
        );
      });
    });
  }
}
