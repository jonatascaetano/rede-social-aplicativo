import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/entity_save_dto.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/scoped_model/update_review_entity_model.dart';

// ignore: must_be_immutable
class UpdateReviewEntity extends StatefulWidget {
  BuildContext contextEntityPage;
  String review;
  EntitySaveMini entitySaveMini;
  UpdateReviewEntity({required this.review, required this.entitySaveMini, required this.contextEntityPage, Key? key}) : super(key: key);

  @override
  _UpdateReviewEntityState createState() => _UpdateReviewEntityState();
}

class _UpdateReviewEntityState extends State<UpdateReviewEntity> {
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
      return ScopedModel<UpdateReviewEntityModel>(
          model: UpdateReviewEntityModel(),
          child: ScopedModelDescendant<UpdateReviewEntityModel>(builder: (context, child, review) {
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
                                    color: theme.title,
                                    fontSize: theme.sizeTitle,
                                    letterSpacing: theme.letterSpacingTitle,
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
                                EntitySaveDTO entitySaveDTO = EntitySaveDTO(
                                  idEntitySave: widget.entitySaveMini.id,
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
                                  level: null,
                                  spoiler: spoiler,
                                  release: DateTime.now().toString(),
                                );
                                review.updateReview(entitySaveDTO: entitySaveDTO, contextEntityPage: widget.contextEntityPage, contextUpdateReviewPage: context);
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
                    review.load
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
          }));
    });
  }
}
