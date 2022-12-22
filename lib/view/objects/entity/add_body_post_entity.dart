import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/post_update_dto.dart';
import 'package:social_network_application/entities/mini_dto/post_update_mini.dart';
import 'package:social_network_application/scoped_model/entity_model2.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

// ignore: must_be_immutable
class AddBodyPostEntity extends StatefulWidget {
  PostUpdateMini postUpdateMini;
  BuildContext contextEntityPage;
  AddBodyPostEntity(
      {required this.postUpdateMini, required this.contextEntityPage, Key? key})
      : super(key: key);

  @override
  _AddBodyPostEntityState createState() => _AddBodyPostEntityState();
}

class _AddBodyPostEntityState extends State<AddBodyPostEntity> {
  TextEditingController body = TextEditingController();
  bool spoiler = false;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Form(
        key: _globalKey,
        child: Scaffold(
          appBar: AppBar(
              elevation: 0.0,
              title: Text(
                'Add comment in post',
                style: TextStyle(
                  color: theme.title,
                  fontSize: theme.sizeAppBar,
                  letterSpacing: theme.letterSpacingAppBar,
                  fontWeight: FontWeight.normal,
                ),
              )),
          body: Stack(children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
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
                        return 'comment cannot be null';
                      }
                      return null;
                    },
                    minLines: 10,
                    maxLines: 10,
                    maxLength: 280,
                    controller: body,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      label: Text("comment"),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.buttonMain,
                      elevation: 0.0,
                    ),
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        PostUpdateDTO postUpdateDTO = PostUpdateDTO(
                          idPost: widget.postUpdateMini.id,
                          level: null,
                          release: null,
                          body: body.text,
                          category: 0,
                          idAuthor: widget.postUpdateMini.author!.id,
                          idEntity: null,
                          // idSeason: null,
                          // idEpisode: null,
                          evaluation: 0,
                          spoiler: spoiler,
                        );
                        ScopedModel.of<EntityModel2>(widget.contextEntityPage)
                            .addBodyPost(
                                postUpdateDTO: postUpdateDTO, context: context);
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
                  ScopedModel.of<EntityModel2>(widget.contextEntityPage).load
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
          ]),
        ),
      );
    });
    /*
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<EntityModel>(
          builder: (context, child, entity) {
        return
      });
    });
    */
  }
}
