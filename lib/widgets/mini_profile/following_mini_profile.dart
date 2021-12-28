import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/scoped_model/following_model.dart';
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
    return ScopedModelDescendant<FollowingModel>(
        builder: (context, child, following) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 40.0,
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (widget.userMini.id != following.id) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => User(
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
                            radius: 30.0,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: const Icon(
                              Icons.person,
                              size: 30.0,
                            ),
                            radius: 30.0,
                          ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    SizedBox(
                      width: widget.isUser ? 130.0 : 200.0,
                      child: Text(
                        widget.userMini.name,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              widget.isUser
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          following.removeFollowing(
                              idFollowing: widget.userMini.id,
                              context: context);
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
