import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/scoped_model/database_model.dart';
import 'package:social_network_application/scoped_model/language_model.dart';
import 'package:social_network_application/view/widgets/mini_profile/entities_mini_profile.dart';
import 'package:social_network_application/view/profile/followers.dart';
import 'package:social_network_application/view/profile/following.dart';

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
        color: Colors.transparent,
        height: 500.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.user.image != null
                  ? CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.user.image.toString()),
                      radius: 60.0,
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: const Icon(
                        Icons.person,
                        size: 80.0,
                      ),
                      radius: 60.0,
                    ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.user.name,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.purple,
                    ),
                  ),
                  widget.user.checked
                      ? const CircleAvatar(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          child: Icon(
                            Icons.done,
                            color: Colors.blue,
                          ),
                        )
                      : Container()
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              widget.user.city != null
                  ? Column(
                      children: [
                        Text(
                          widget.user.city!,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                      ],
                    )
                  : Container(),
              widget.user.description != null
                  ? Column(
                      children: [
                        Text(
                          widget.user.description!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                      ],
                    )
                  : Container(),
              !widget.isUser
                  ? FutureBuilder<int?>(
                      future: database.checkFollowing(
                          id: widget.user.id, idFollowing: database.id),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Container();
                          default:
                            // ignore: avoid_print
                            print("FutureBuild checkFollowing: " +
                                snapshot.hasData.toString());
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              if (snapshot.data! == 404) {
                                return ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Follow'));
                              } else if (snapshot.data! == 200) {
                                return ElevatedButton(
                                    onPressed: () {},
                                    child: const Text('Unfollow'));
                              } else {
                                return Container();
                              }
                            }
                        }
                      })
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Followers(
                                    idUser: widget.user.id,
                                    isUser: widget.isUser,
                                  )));
                    },
                    child: Text(
                      'Followers ' + widget.user.followers.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Following(
                                    idUser: widget.user.id,
                                    isUser: widget.isUser,
                                  )));
                    },
                    child: Text(
                      'Following ' + widget.user.following.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: LanguageModel()
                      .typeEntities
                      .map((e) => EntityMiniProfile(
                          index: LanguageModel().typeEntities.indexOf(e)))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
