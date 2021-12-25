import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/scoped_model/database_model.dart';
import 'package:social_network_application/view/objects/user.dart';

// ignore: must_be_immutable
class FollowingMiniProfile extends StatefulWidget {
  UserMini userMini;
  bool isUser;
  FollowingMiniProfile({required this.userMini, required this.isUser, Key? key})
      : super(key: key);

  @override
  _FollowingMiniProfileState createState() => _FollowingMiniProfileState();
}

class _FollowingMiniProfileState extends State<FollowingMiniProfile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<DatabaseModel>(
        builder: (context, child, database) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100.0,
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (widget.userMini.id != database.id) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => User(
                                  isUser: false,
                                  userMini: widget.userMini,
                                )));
                  }
                },
                child: Row(
                  children: [
                    widget.userMini.image != null
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.userMini.image.toString()),
                            radius: 20.0,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: const Icon(
                              Icons.person,
                              size: 20.0,
                            ),
                            radius: 20.0,
                          ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    SizedBox(
                      width: 130.0,
                      child: Text(
                        widget.userMini.name,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    /*
                    const SizedBox(
                      width: 2.0,
                    ),
                    widget.userMini.checked
                        ? Icon(
                            Icons.check_circle_sharp,
                            color: Colors.blue[900],
                          )
                        : Container(),
                    */
                  ],
                ),
              )),
              widget.isUser
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          database.removeFollowing(
                              idFollower: database.id,
                              idFollowing: widget.userMini.id);
                        },
                        child: const Text('remove'),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      );
    });
  }
}
