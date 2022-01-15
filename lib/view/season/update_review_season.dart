import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/entity_save_dto.dart';
import 'package:social_network_application/scoped_model/season_model.dart';

// ignore: must_be_immutable
class UpdateReviewSeason extends StatefulWidget {
  String review;
  UpdateReviewSeason({required this.review, Key? key}) : super(key: key);

  @override
  _UpdateReviewSeasonState createState() => _UpdateReviewSeasonState();
}

class _UpdateReviewSeasonState extends State<UpdateReviewSeason> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.review;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SeasonModel>(
        builder: (context, child, season) {
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: controller,
                    minLines: 1,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      label: Text("review"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      EntitySaveDTO entitySaveDTO = EntitySaveDTO(
                        idEntitySave: season.entitySaveMini!.id,
                        idUser: null,
                        idEntity: null,
                        idSeason: null,
                        idEpisode: null,
                        category: null,
                        goal: null,
                        rated: null,
                        reviewed: true,
                        evaluation: null,
                        review: controller.text,
                        typeEntitySave: null,
                      );
                      season.updateReviewEntitySave(
                          entitySaveDTO: entitySaveDTO, context: context);
                    },
                    child: const Text("Confirm"),
                  ),
                ],
              ),
            ),
            season.load
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
