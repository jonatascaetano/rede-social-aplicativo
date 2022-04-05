import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/post_talk_group_dto.dart';
import 'package:social_network_application/scoped_model/new_talk_user_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

// ignore: must_be_immutable
class NewTalkGroup extends StatefulWidget {
  String idGroup;
  BuildContext contextScreenGroup;
  NewTalkGroup({required this.idGroup, required this.contextScreenGroup, Key? key}) : super(key: key);

  @override
  State<NewTalkGroup> createState() => _NewTalkGroupState();
}

class _NewTalkGroupState extends State<NewTalkGroup> {
  TextEditingController controller = TextEditingController();
  TextEditingController title = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool spoiler = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<NewPostModel>(
          model: NewPostModel(),
          child: ScopedModelDescendant<NewPostModel>(builder: (context, child, post) {
            return Form(
              key: _globalKey,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  title: Text(
                    "Post",
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
                          !spoiler
                              ? Container()
                              : TextFormField(
                                  validator: (value) {
                                    if (spoiler && value!.isEmpty) {
                                      return 'your title cannot be empty';
                                    }
                                  },
                                  controller: title,
                                  minLines: 2,
                                  maxLines: 2,
                                  decoration: const InputDecoration(
                                    label: Text("title"),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'your post cannot be empty';
                              }
                            },
                            controller: controller,
                            minLines: 10,
                            maxLines: 10,
                            decoration: const InputDecoration(
                              label: Text("post"),
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
                            onPressed: () async {
                              if (_globalKey.currentState!.validate()) {
                                String id = await post.getId();
                                PostTalkGroupDTO postTalkGroupDTO = PostTalkGroupDTO(
                                  idPost: null,
                                  release: DateTime.now().toString(),
                                  body: controller.text,
                                  spoiler: spoiler,
                                  idAuthor: id,
                                  idGroup: widget.idGroup,
                                  title: title.text,
                                );
                                post.newTalkGroup(post: postTalkGroupDTO, context: context, contextScreenGroup: widget.contextScreenGroup);
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
                    post.load
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
