import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/season_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/mini_seasons/episode_mini_season.dart';

class AllEpisodesSeason extends StatefulWidget {
  const AllEpisodesSeason({Key? key}) : super(key: key);

  @override
  _AllEpisodesSeasonState createState() => _AllEpisodesSeasonState();
}

class _AllEpisodesSeasonState extends State<AllEpisodesSeason> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<SeasonModel>(builder: (context, child, season) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              season.seasonMini.name + " seasons",
              style: TextStyle(
                color: theme.title,
                fontSize: 24.0,
                letterSpacing: 1.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          body: GridView.count(
            childAspectRatio: 1.0 / 1.55,
            crossAxisCount: 2,
            children: season.episodes.map((e) {
              return EpisodeMiniSeason(
                episodeMini: e,
              );
            }).toList(),
          ),
        );
      });
    });
  }
}
