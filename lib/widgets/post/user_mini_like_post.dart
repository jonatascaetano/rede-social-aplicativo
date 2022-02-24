import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/objects/user.dart';
import 'package:social_network_application/view/tabs/profile.dart';

// ignore: must_be_immutable
class UserMiniLikePost extends StatefulWidget {
  UserMini userMini;
  UserMiniLikePost({required this.userMini, Key? key}) : super(key: key);

  @override
  _UserMiniLikePostState createState() => _UserMiniLikePostState();
}

class _UserMiniLikePostState extends State<UserMiniLikePost> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return GestureDetector(
        onTap: () {
          ScopedModel.of<ProfileModel>(context).userMini.id ==
                  widget.userMini.id
              ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profile()))
              : Navigator.push(
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
                        backgroundImage:
                            NetworkImage(widget.userMini.imageProfile!),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width - 90,
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
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
