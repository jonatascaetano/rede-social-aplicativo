import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/post/new_talk_group.dart';
import 'package:social_network_application/view/post/new_talk_user.dart';

// ignore: must_be_immutable
class AddedPost extends StatelessWidget {
  bool user;
  String? idGroup;
  AddedPost({required this.user, required this.idGroup, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Container(
        color: theme.background,
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: () {
            if (user) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewTalkUser(),
                ),
              );
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewTalkGroup(
                            idGroup: idGroup!,
                          )));
            }
          },
          child: TextField(
            enabled: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              fillColor: theme.background,
              hoverColor: theme.background,
              focusColor: theme.background,
              label: const Text("comment"),
              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send),
              ),
            ),
          ),
        ),
      );
    });
  }
}
