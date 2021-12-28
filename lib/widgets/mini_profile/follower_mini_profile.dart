import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/scoped_model/followers_model.dart';
import 'package:social_network_application/view/objects/user.dart';

// ignore: must_be_immutable
class FollowerMiniProfile extends StatefulWidget {
  UserMini userMini;
  bool isUser;
  FollowerMiniProfile({required this.userMini, required this.isUser, Key? key})
      : super(key: key);

  @override
  _FollowerMiniProfileState createState() => _FollowerMiniProfileState();
}

class _FollowerMiniProfileState extends State<FollowerMiniProfile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FollowersModel>(
        builder: (context, child, followers) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 40.0,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (widget.userMini.id != followers.id) {
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
                              backgroundImage: NetworkImage(
                                  widget.userMini.image.toString()),
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
                ),
              ),
              widget.isUser
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          followers.removeFollower(
                              idFollower: widget.userMini.id, context: context);
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
