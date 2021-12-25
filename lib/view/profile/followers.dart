import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/scoped_model/database_model.dart';
import 'package:social_network_application/scoped_model/theme_model.dart';
import 'package:social_network_application/view/widgets/mini_profile/follower_mini_profile.dart';

// ignore: must_be_immutable
class Followers extends StatefulWidget {
  String idUser;
  bool isUser;
  Followers({required this.idUser, required this.isUser, Key? key})
      : super(key: key);

  @override
  _FollowersState createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<DatabaseModel>(
        builder: (context, child, database) {
      return ScopedModelDescendant<ThemeModel>(
          builder: (context, child, theme) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Followers",
                style: TextStyle(color: Colors.purple),
              ),
              elevation: 0.0,
            ),
            body: FutureBuilder<List<dynamic>>(
                future: database.getFollowers(idUser: widget.idUser),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Container();
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      if (!snapshot.hasData) {
                        return Container();
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              UserMini userMini =
                                  UserMini.fromMap(map: snapshot.data![index]);
                              return FollowerMiniProfile(
                                userMini: userMini,
                                isUser: widget.isUser,
                              );
                            });
                      }
                  }
                }));
      });
    });
  }
}
