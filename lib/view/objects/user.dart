import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/entities/mini_dto/worker_mini.dart';
import 'package:social_network_application/scoped_model/database_model.dart';
import 'package:social_network_application/scoped_model/language_model.dart';
import 'package:social_network_application/view/profile/area_post.dart';
import 'package:social_network_application/view/profile/followers.dart';
import 'package:social_network_application/view/profile/following.dart';
import 'package:social_network_application/view/widgets/mini_profile/entities_mini_profile.dart';
import 'package:social_network_application/view/widgets/mini_profile/worker_mini_profile.dart';

// ignore: must_be_immutable
class User extends StatefulWidget {
  UserMini userMini;
  bool isUser;
  User({required this.userMini, required this.isUser, Key? key})
      : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<DatabaseModel>(
        builder: (context, child, database) {
      return Scaffold(
          body: ListView(
        children: [
          //inicio da area profile
          Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.userMini.image != null
                      ? CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.userMini.image.toString()),
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.userMini.name,
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        widget.userMini.checked
                            ? Icon(
                                Icons.check_circle_sharp,
                                color: Colors.blue[900],
                              )
                            : Container()
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  widget.userMini.city != null
                      ? Column(
                          children: [
                            Text(
                              widget.userMini.city!,
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
                  FutureBuilder<int?>(
                      future: database.checkFollowing(
                          id: database.id, idFollowing: widget.userMini.id),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Container();
                          case ConnectionState.waiting:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          default:
                            // ignore: avoid_print
                            print("FutureBuild checkFollowing: " +
                                snapshot.hasData.toString());
                            if (!snapshot.hasData) {
                              return Container();
                            } else {
                              if (snapshot.data! == 404) {
                                return ElevatedButton(
                                    onPressed: () {
                                      database.addFollowing(
                                          idFollower: database.id,
                                          idFollowing: widget.userMini.id);
                                    },
                                    child: const Text('Follow'));
                              } else if (snapshot.data! == 200) {
                                return ElevatedButton(
                                    onPressed: () {
                                      database.removeFollowing(
                                          idFollower: database.id,
                                          idFollowing: widget.userMini.id);
                                    },
                                    child: const Text('Unfollow'));
                              } else {
                                return Container();
                              }
                            }
                        }
                      }),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Followers(
                                          idUser: widget.userMini.id,
                                          isUser: false,
                                        )));
                          },
                          child: Row(
                            children: [
                              const Text(
                                'Followers',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                widget.userMini.followers.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Following(
                                            idUser: widget.userMini.id,
                                            isUser: false,
                                          )));
                            },
                            child: Row(
                              children: [
                                const Text(
                                  'Following',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  widget.userMini.following.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  widget.userMini.description != null
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.userMini.description!,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                          ],
                        )
                      : Container(),
                  FutureBuilder<List<dynamic>>(
                      future:
                          database.getWorkersUser(idUser: widget.userMini.id),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Container();
                          default:
                            if (!snapshot.hasData) {
                              return const SizedBox(
                                height: 100.0,
                                child: Center(child: Text("no data")),
                              );
                            } else {
                              List<WorkerMini> list = [];
                              for (var map in snapshot.data!) {
                                WorkerMini workerMini =
                                    WorkerMini.fromMap(map: map as Map);
                                list.add(workerMini);
                              }
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: list.length,
                                        itemBuilder: (context, index) {
                                          return WorkerMiniProfile(
                                            workerMini: list[index],
                                            isUser: false,
                                          );
                                        }),
                                  )
                                ],
                              );
                            }
                        }
                      }),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
          ),

          //final da area profile

          //inicio area post

          const SizedBox(
            height: 16.0,
          ),
          widget.userMini.privacy
              ? FutureBuilder<int?>(
                  future: database.checkFollowing(
                      id: widget.userMini.id, idFollowing: database.id),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
                      default:
                        if (!snapshot.hasData) {
                          return const Center(
                            child: Text("account not found"),
                          );
                        } else {
                          if (snapshot.data == 404) {
                            return const Center(
                              child: Text("Private account"),
                            );
                          } else if (snapshot.data == 200) {
                            return AreaPost(
                                id: widget.userMini.id, isUser: widget.isUser);
                          } else {
                            return Container();
                          }
                        }
                    }
                  })
              : AreaPost(id: widget.userMini.id, isUser: widget.isUser)
        ],
      ));
    });
  }
}
