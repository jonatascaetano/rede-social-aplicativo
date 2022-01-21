import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/entity_save_dto.dart';
import 'package:social_network_application/scoped_model/episode_model.dart';

// ignore: must_be_immutable
class UpdateReviewEpisode extends StatefulWidget {
  String review;
  UpdateReviewEpisode({required this.review, Key? key}) : super(key: key);

  @override
  _UpdateReviewEpisodeState createState() => _UpdateReviewEpisodeState();
}

class _UpdateReviewEpisodeState extends State<UpdateReviewEpisode> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.review;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<EpisodeModel>(
        builder: (context, child, episode) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text(
            "Review",
            style: TextStyle(
              color: Colors.purple,
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
              child: ListView(
                children: [
                  TextField(
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
                      primary: Colors.purple.shade300,
                      elevation: 0.0,
                    ),
                    onPressed: () {
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
                        typeEntitySave: null,
                      );
                      episode.updateReviewEntitySave(
                          entitySaveDTO: episodeSaveDTO, context: context);
                    },
                    child: const Text(
                      "Confirm",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 2.0,
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
    });
  }
}
