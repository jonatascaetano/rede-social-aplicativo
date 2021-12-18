import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/scoped_model/database_model.dart';

// ignore: must_be_immutable
class AreaProfile extends StatefulWidget {
  UserMini user;
  bool isUser;
  AreaProfile({required this.user, required this.isUser, Key? key})
      : super(key: key);

  @override
  _AreaProfileState createState() => _AreaProfileState();
}

class _AreaProfileState extends State<AreaProfile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<DatabaseModel>(
        builder: (context, child, database) {
      return Container(
        color: Colors.purple[200],
        height: 400.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.user.image != null
                  ? Expanded(
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.user.image.toString()),
                        radius: 100.0,
                      ),
                    )
                  : Expanded(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: const Icon(
                          Icons.person,
                          size: 150.0,
                        ),
                        radius: 100.0,
                      ),
                    ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                widget.user.name!,
                style: const TextStyle(
                  fontSize: 21,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              widget.user.description != null
                  ? Column(
                      children: [
                        Text(
                          widget.user.description!,
                          style: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                      ],
                    )
                  : Container(),
              !widget.isUser
                  ? FutureBuilder<bool>(
                      future: database.checkFollowing(
                          id: widget.user.id!, idFollowing: database.id),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Container();
                          default:
                            bool isFollowing = snapshot.data!;
                            if (!isFollowing) {
                              return Column(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("Follow")),
                                  const SizedBox(
                                    height: 16.0,
                                  )
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("Unfollow")),
                                  const SizedBox(
                                    height: 16.0,
                                  )
                                ],
                              );
                            }
                        }
                      })
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Follower ' + widget.user.followers!.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Following ' + widget.user.following!.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
