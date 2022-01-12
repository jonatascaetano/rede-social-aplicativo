import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/followers_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/mini_profile/follower_mini_profile.dart';

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
    return ScopedModel<FollowersModel>(
        model: FollowersModel(idUser: widget.idUser),
        child: ScopedModelDescendant<FollowersModel>(
            builder: (context, child, followers) {
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
                body: Stack(
                  children: [
                    followers.followers.isEmpty && !followers.load
                        ? Center(
                            child: Container(
                                width: 250,
                                height: 250,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: const Color(0xffce93d8)),
                                ),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('followers'),
                                  ),
                                )),
                          )
                        : ListView.builder(
                            itemCount: followers.followers.length,
                            itemBuilder: (context, index) {
                              return FollowerMiniProfile(
                                userMini: followers.followers[index],
                                isUser: widget.isUser,
                              );
                            }),
                    followers.load
                        ? Positioned(
                            bottom: 0.1,
                            child: SizedBox(
                              height: 5.0,
                              width: MediaQuery.of(context).size.width,
                              child: const LinearProgressIndicator(),
                            ),
                          )
                        : Container(),
                  ],
                ));
          });
        }));
  }
}
