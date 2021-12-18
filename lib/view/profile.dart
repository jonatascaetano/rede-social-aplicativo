import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/scoped_model/database_model.dart';
import 'package:social_network_application/view/profile/area_post.dart';
import 'package:social_network_application/view/profile/area_profile.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  String id;
  bool isUser;
  Profile({required this.id, required this.isUser, Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<DatabaseModel>(
        builder: (context, child, database) {
      return Scaffold(
        body: FutureBuilder(
            future: database.getProfile(id: widget.id),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("Account unavailable"),
                    );
                  } else {
                    // ignore: avoid_print
                    print(snapshot.data.toString());
                    UserMini user = UserMini.fromMap(map: snapshot.data as Map);
                    if (!user.status!) {
                      return const Center(
                        child: Text("Account unavailable"),
                      );
                    } else {
                      return ListView(
                        children: [
                          AreaProfile(
                            user: user,
                            isUser: widget.isUser,
                          ),
                          // const SizedBox(
                          //   height: 16.0,
                          // ),
                          !widget.isUser && user.privacy!
                              ? FutureBuilder<bool>(
                                  future: database.checkFollowing(
                                      id: user.id!, idFollowing: database.id),
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.none:
                                      case ConnectionState.waiting:
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      default:
                                        bool isFollowing = snapshot.data!;
                                        if (!isFollowing) {
                                          return const Center(
                                            child: Text("Private account"),
                                          );
                                        } else {
                                          return AreaPost(
                                              id: widget.id,
                                              isUser: widget.isUser);
                                        }
                                    }
                                  })
                              : AreaPost(id: widget.id, isUser: widget.isUser)
                        ],
                      );
                    }
                  }
              }
            }),
      );
    });
  }
}
