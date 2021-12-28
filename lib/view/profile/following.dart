import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/following_model.dart';
import 'package:social_network_application/scoped_model/auxiliar/theme_model.dart';
import 'package:social_network_application/widgets/mini_profile/following_mini_profile.dart';

// ignore: must_be_immutable
class Following extends StatefulWidget {
  String idUser;
  bool isUser;
  Following({required this.idUser, required this.isUser, Key? key})
      : super(key: key);

  @override
  _FollowingState createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<FollowingModel>(
        model: FollowingModel(idUser: widget.idUser),
        child: ScopedModelDescendant<FollowingModel>(
            builder: (context, child, following) {
          return ScopedModelDescendant<ThemeModel>(
              builder: (context, child, theme) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text(
                    "Following",
                    style: TextStyle(color: Colors.purple),
                  ),
                  elevation: 0.0,
                ),
                body: Stack(
                  children: [
                    following.following.isEmpty && !following.load
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
                                    child: Text('following'),
                                  ),
                                )),
                          )
                        : ListView.builder(
                            itemCount: following.following.length,
                            itemBuilder: (context, index) {
                              return FollowingMiniProfile(
                                userMini: following.following[index],
                                isUser: widget.isUser,
                              );
                            }),
                    following.load
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
