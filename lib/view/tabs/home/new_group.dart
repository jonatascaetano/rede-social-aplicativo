import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/group_dto.dart';
import 'package:social_network_application/scoped_model/new_group_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({Key? key}) : super(key: key);
  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  TextEditingController description = TextEditingController();
  TextEditingController name = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<NewGroupModel>(
          model: NewGroupModel(),
          child: ScopedModelDescendant<NewGroupModel>(builder: (context, child, group) {
            return Form(
              key: _globalKey,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  title: Text(
                    'New Group',
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
                          const SizedBox(
                            height: 16.0,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'your name cannot be empty';
                              }
                            },
                            controller: name,
                            minLines: 2,
                            maxLines: 2,
                            decoration: const InputDecoration(
                              label: Text("name"),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'your description cannot be empty';
                              }
                            },
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: theme.buttonMain,
                              elevation: 0.0,
                            ),
                            onPressed: () async {
                              if (_globalKey.currentState!.validate()) {
                                String id = await group.getId();
                                GroupDTO groupDTO = GroupDTO(
                                  name: name.text,
                                  description: description.text,
                                  idCreator: id,
                                  image: null,
                                  creationDate: DateTime.now().toString(),
                                );
                                group.newGroup(groupDTO: groupDTO, contextNewGroup: context);
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
                    group.load
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
