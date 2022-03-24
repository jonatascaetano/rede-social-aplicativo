import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/scoped_model/followers_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/objects/user.dart';

// ignore: must_be_immutable
class FollowerMiniProfile extends StatefulWidget {
  UserMini userMini;
  bool isUser;
  FollowerMiniProfile({required this.userMini, required this.isUser, Key? key}) : super(key: key);

  @override
  _FollowerMiniProfileState createState() => _FollowerMiniProfileState();
}

class _FollowerMiniProfileState extends State<FollowerMiniProfile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<FollowersModel>(builder: (context, child, followers) {
        return GestureDetector(
          onTap: () {
            if (widget.userMini.id != followers.id) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => User(
                            userMini: widget.userMini,
                          )));
            }
          },
          child: Container(
            margin: const EdgeInsets.all(4.0),
            width: 200.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.shadow,
              ), //  const Color(0xffce93d8)),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    child: Column(
                  children: [
                    widget.userMini.imageProfile != null
                        ? Container(
                            height: 150,
                            width: 200,
                            decoration: BoxDecoration(
                              color: theme.shadow,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                              image: DecorationImage(
                                image: NetworkImage(widget.userMini.imageProfile!),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                              color: theme.shadow,
                            ),
                            height: 150,
                            width: 200,
                            child: Center(
                              child: Icon(
                                Icons.image,
                                color: theme.emphasis,
                                size: 100,
                              ),
                            )),
                    // ? CircleAvatar(
                    //     backgroundImage: NetworkImage(widget
                    //         .workerMini.entity.images[0]
                    //         .toString()),
                    //     radius: 30.0,
                    //   )
                    // : CircleAvatar(
                    //     backgroundColor: Colors.grey[300],
                    //     child: const Icon(
                    //       Icons.image,
                    //       size: 30.0,
                    //     ),
                    //     radius: 30.0,
                    //   ),
                    const SizedBox(
                      height: 8.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                      child: Text(
                        widget.userMini.name,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1.0,
                          color: theme.title,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                )),
                const SizedBox(
                  height: 2.0,
                ),
                !widget.isUser
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                        child: ElevatedButton(
                          onPressed: () {
                            followers.removeFollower(idFollower: widget.userMini.id, context: context);
                          },
                          child: Text(
                            'remove',
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 1.0,
                              color: theme.buttonMainText,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: theme.detail,
                            elevation: 1.0,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
        /*
        Padding(
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
                                backgroundImage:
                                    NetworkImage(widget.userMini.image!),
                                radius: 30.0,
                              )
                            : CircleAvatar(
                                backgroundColor: theme.shadow,
                                child: Icon(
                                  Icons.person,
                                  size: 30.0,
                                  color: theme.emphasis,
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
                            style: TextStyle(
                              fontSize: 19,
                              color: theme.title,
                              fontWeight: FontWeight.normal,
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
                          style: ElevatedButton.styleFrom(
                            primary: theme.button,
                            elevation: 0.0,
                          ),
                          onPressed: () {
                            followers.removeFollower(
                                idFollower: widget.userMini.id,
                                context: context);
                          },
                          child: Text(
                            'remove',
                            style: TextStyle(
                              fontSize: 19,
                              letterSpacing: 1.0,
                              color: theme.buttonText,
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        );
        */
      });
    });
  }
}
