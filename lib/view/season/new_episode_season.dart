import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/episode_dto.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';
import 'package:social_network_application/scoped_model/new_episode_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

// ignore: must_be_immutable
class NewEpisodeSeason extends StatefulWidget {
  SeasonMini seasonMini;
  BuildContext context;
  NewEpisodeSeason({required this.seasonMini, required this.context, Key? key})
      : super(key: key);

  @override
  _NewEpisodeSeasonState createState() => _NewEpisodeSeasonState();
}

class _NewEpisodeSeasonState extends State<NewEpisodeSeason> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController numberEpisode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<NewEpisodeModel>(
          model: NewEpisodeModel(),
          child: ScopedModelDescendant<NewEpisodeModel>(
              builder: (context, child, episode) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: Text(
                  "New episode",
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 30.0),
                    child: ListView(
                      children: [
                        TextField(
                          controller: name,
                          minLines: 1,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            label: Text("name"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          controller: description,
                          minLines: 10,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            label: Text("description"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          controller: numberEpisode,
                          minLines: 1,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            label: Text("episode number"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: theme.buttonMain,
                            elevation: 0.0,
                          ),
                          onPressed: () {
                            EpisodeDTO episodeDTO = EpisodeDTO(
                              name: name.text,
                              description: description.text,
                              numberEpisode: int.parse(numberEpisode.text),
                              idEpisode: '',
                            );
                            episode.createEpisode(
                              episodeDTO: episodeDTO,
                              idSeason: widget.seasonMini.id,
                              context: context,
                            );
                          },
                          child: Text(
                            "Confirm",
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 2.0,
                              color: theme.buttonMainText,
                            ),
                          ),
                        ),
                      ],
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
          }));
    });
  }
}
