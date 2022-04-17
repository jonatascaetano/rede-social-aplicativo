import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/objects/user.dart';

// ignore: must_be_immutable
class UserMiniResult extends StatefulWidget {
  UserMini userMini;
  UserMiniResult({required this.userMini, Key? key}) : super(key: key);

  @override
  _UserMiniResultState createState() => _UserMiniResultState();
}

class _UserMiniResultState extends State<UserMiniResult> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => User(
                        userMini: widget.userMini,
                      )));
        },
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                widget.userMini.imageProfile != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(widget.userMini.imageProfile!),
                        radius: 30.0,
                      )
                    : CircleAvatar(
                        backgroundColor: theme.shadow,
                        child: Icon(Icons.person, color: theme.emphasis),
                        radius: 30.0,
                      ),
                const SizedBox(
                  width: 8.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200.0,
                      child: Text(
                        widget.userMini.name,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.title,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Text(
                      LanguageModel().typeObject[0],
                      style: TextStyle(
                        fontSize: theme.sizeText,
                        color: theme.subtitle,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
