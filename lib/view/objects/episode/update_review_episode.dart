import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/entity_save_dto.dart';
import 'package:social_network_application/scoped_model/episode_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

// ignore: must_be_immutable
class UpdateReviewEpisode extends StatefulWidget {
  String review;
  UpdateReviewEpisode({required this.review, Key? key}) : super(key: key);

  @override
  _UpdateReviewEpisodeState createState() => _UpdateReviewEpisodeState();
}

class _UpdateReviewEpisodeState extends State<UpdateReviewEpisode> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool spoiler = false;

  @override
  void initState() {
    super.initState();
    controller.text = widget.review;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<EpisodeModel>(builder: (context, child, episode) {
        return Form(
          key: _globalKey,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text(
                "Review",
                style: TextStyle(
                  color: theme.title,
                  fontSize: theme.sizeAppBar,
                  letterSpacing: theme.letterSpacingAppBar,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Contains spoiler?",
                              style: TextStyle(
                                fontSize: 16,
                                letterSpacing: 1.0,
                                color: ScopedModel.of<ThemeModel>(context).title,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Switch.adaptive(
                                value: spoiler,
                                onChanged: (value) {
                                  setState(() {
                                    spoiler = value;
                                  });
                                }),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'your review cannot be empty';
                          }
                        },
                        controller: controller,
                        minLines: 10,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          label: Text("review"),
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
                          if (_globalKey.currentState!.validate()) {
                            EntitySaveDTO episodeSaveDTO = EntitySaveDTO(
                              idEntitySave: episode.entitySaveMini!.id,
                              idUser: null,
                              idEpisode: null,
                              idSeason: null,
                              idEntity: null,
                              category: null,
                              goal: null,
                              rated: null,
                              reviewed: true,
                              evaluation: null,
                              review: controller.text,
                              level: null,
                              spoiler: spoiler,
                              release: DateTime.now().toString(),
                            );
                            episode.updateReviewEntitySave(entitySaveDTO: episodeSaveDTO, context: context);
                          }
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            color: theme.buttonMainText,
                            fontSize: theme.sizeButton,
                            letterSpacing: theme.letterSpacingButton,
                            fontWeight: FontWeight.normal,
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
          ),
        );
      });
    });
  }
}
