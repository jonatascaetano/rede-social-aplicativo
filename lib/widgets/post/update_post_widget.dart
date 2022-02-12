import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/converts/convert_date.dart';
import 'package:social_network_application/converts/convert_to_enum.dart';
import 'package:social_network_application/entities/mini_dto/post_update_mini.dart';
import 'package:social_network_application/enuns/level.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/scoped_model/user_model.dart';
import 'package:social_network_application/view/objects/entity.dart';
import 'package:social_network_application/view/objects/episode.dart';
import 'package:social_network_application/view/objects/season.dart';
import 'package:social_network_application/view/objects/user.dart';
import 'package:social_network_application/view/post/comments_post_update.dart';

// ignore: must_be_immutable
class UpdatePostWidget extends StatefulWidget {
  PostUpdateMini postUpdateMini;
  bool screenComment;
  bool screenUser;
  BuildContext contextPage;
  UpdatePostWidget(
      {required this.postUpdateMini,
      required this.screenComment,
      required this.screenUser,
      required this.contextPage,
      Key? key})
      : super(key: key);

  @override
  _UpdatePostWidgetState createState() => _UpdatePostWidgetState();
}

class _UpdatePostWidgetState extends State<UpdatePostWidget> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Column(
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.postUpdateMini.user!.image != null
                  ? GestureDetector(
                      onTap: () {
                        if (widget.postUpdateMini.user!.id !=
                                ScopedModel.of<ProfileModel>(context)
                                    .userMini
                                    .id &&
                            !widget.screenUser) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => User(
                                    userMini: widget.postUpdateMini.user!)),
                          );
                        }
                      },
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.postUpdateMini.user!.image!),
                        radius: 30.0,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        if (widget.postUpdateMini.user!.id !=
                                ScopedModel.of<ProfileModel>(context)
                                    .userMini
                                    .id &&
                            !widget.screenUser) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => User(
                                    userMini: widget.postUpdateMini.user!)),
                          );
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: theme.shadow,
                        child: Icon(
                          Icons.image,
                          color: theme.emphasis,
                        ),
                        radius: 30.0,
                      ),
                    ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                  child: widget.postUpdateMini.level == Level.ENTITY
                      ? entity(
                          context: context,
                          postUpdateMini: widget.postUpdateMini,
                          screenUser: widget.screenUser,
                        )
                      : widget.postUpdateMini.level == Level.SEASON
                          ? season(
                              postUpdateMini: widget.postUpdateMini,
                              context: context,
                              screenUser: widget.screenUser,
                            )
                          : episode(
                              postUpdateMini: widget.postUpdateMini,
                              context: context,
                              screenUser: widget.screenUser,
                            )),
              const SizedBox(
                width: 8.0,
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  if (widget.postUpdateMini.user!.id ==
                      ScopedModel.of<ProfileModel>(context).userMini.id) {
                    ScopedModel.of<ProfileModel>(context)
                        .showDeletePostBottomSheet(
                      context: context,
                      idPost: widget.postUpdateMini.id!,
                      screenComment: widget.screenComment,
                      screenUser: widget.screenUser,
                      contextPage: widget.contextPage,
                    );
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     backgroundColor:
                    //         ScopedModel.of<ThemeModel>(context).background,
                    //     content: Text('delete post?',
                    //         style: TextStyle(
                    //           color:
                    //               ScopedModel.of<ThemeModel>(context).subtitle,
                    //         )),
                    //     action: SnackBarAction(
                    //         label: 'yes',
                    //         textColor:
                    //             ScopedModel.of<ThemeModel>(context).emphasis,
                    //         onPressed: () {
                    //           if (!widget.screenComment && !widget.screenUser) {
                    //             ScopedModel.of<ProfileModel>(context)
                    //                 .removePost(
                    //                     context: context,
                    //                     idPost: widget.postUpdateMini.id!);
                    //           } else if (widget.screenUser &&
                    //               !widget.screenComment) {
                    //             ScopedModel.of<UserModel>(widget.contextPage)
                    //                 .removePost(
                    //                     context: widget.contextPage,
                    //                     idPost: widget.postUpdateMini.id!);
                    //           }
                    //         }),
                    //   ),
                    // );
                  } else {
                    ScopedModel.of<ProfileModel>(context)
                        .showOptionsPostBottomSheet(
                      context: context,
                      idPost: widget.postUpdateMini.id!,
                    );
                  }
                },
                icon: Icon(
                  Icons.more_vert_sharp,
                  size: 21,
                  color: ScopedModel.of<ThemeModel>(context).subtitle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          widget.postUpdateMini.category != 6
              ? Container()
              : Container(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.star,
                        size: 50,
                        color: widget.postUpdateMini.evaluation >= 1
                            ? Colors.yellow[700]
                            : theme.icon,
                      ),
                      Icon(
                        Icons.star,
                        size: 50,
                        color: widget.postUpdateMini.evaluation >= 2
                            ? Colors.yellow[700]
                            : theme.icon,
                      ),
                      Icon(
                        Icons.star,
                        size: 50,
                        color: widget.postUpdateMini.evaluation >= 3
                            ? Colors.yellow[700]
                            : theme.icon,
                      ),
                      Icon(
                        Icons.star,
                        size: 50,
                        color: widget.postUpdateMini.evaluation >= 4
                            ? Colors.yellow[700]
                            : theme.icon,
                      ),
                      Icon(
                        Icons.star,
                        size: 50,
                        color: widget.postUpdateMini.evaluation >= 5
                            ? Colors.yellow[700]
                            : theme.icon,
                      ),
                    ],
                  ),
                ),
          widget.postUpdateMini.category != 6
              ? Container()
              : const SizedBox(
                  height: 8.0,
                ),
          !widget.postUpdateMini.spoiler
              ? widget.postUpdateMini.body != null
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 8.0),
                        child: Text(
                          widget.postUpdateMini.body!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: theme.sizeText,
                            letterSpacing: theme.letterSpacingText,
                            color: theme.title,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    )
                  : Container()
              : ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 8.0),
                  title: Text(
                    'Spoiler',
                    style: TextStyle(
                      fontSize: theme.sizeText,
                      letterSpacing: theme.letterSpacingText,
                      color: theme.title,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.postUpdateMini.body!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: theme.sizeText,
                            letterSpacing: theme.letterSpacingText,
                            color: theme.title,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          const SizedBox(
            height: 8.0,
          ),
          widget.postUpdateMini.level == Level.ENTITY
              ? entityImage(
                  postUpdateMini: widget.postUpdateMini,
                  contextPage: widget.contextPage,
                  screenComment: widget.screenComment,
                  screenUser: widget.screenUser)
              : widget.postUpdateMini.level == Level.SEASON
                  ? seasonImage(
                      postUpdateMini: widget.postUpdateMini,
                      contextPage: widget.contextPage,
                      screenComment: widget.screenComment,
                      screenUser: widget.screenUser)
                  : episodeImage(
                      postUpdateMini: widget.postUpdateMini,
                      contextPage: widget.contextPage,
                      screenComment: widget.screenComment,
                      screenUser: widget.screenUser),

          /*

          widget.postUpdateMini.entity!.image != null
              ? GestureDetector(
                  onTap: () {
                    if (!widget.screenComment) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentsPostUpdate(
                            postUpdateMini: widget.postUpdateMini,
                            screenUser: widget.screenUser,
                            contextPage: widget.contextPage,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    height: (MediaQuery.of(context).size.width / 16) * 9,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: theme.shadow,
                      image: DecorationImage(
                        image:
                            NetworkImage(widget.postUpdateMini.entity!.image!),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    if (!widget.screenComment) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentsPostUpdate(
                            postUpdateMini: widget.postUpdateMini,
                            screenUser: widget.screenUser,
                            contextPage: widget.contextPage,
                          ),
                        ),
                      );
                    }
                  },

                  child: Container(
                    color: theme.shadow,
                    height: (MediaQuery.of(context).size.width / 16) * 9,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Icon(
                        Icons.image,
                        size: 100,
                        color: theme.emphasis,
                      ),
                    ),
                  ),
                ),

                */

          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (!widget.screenComment && !widget.screenUser) {
                      ScopedModel.of<ProfileModel>(context).updateLikePost(
                          context: context, idPost: widget.postUpdateMini.id!);
                    } else if (widget.screenUser && !widget.screenComment) {
                      ScopedModel.of<UserModel>(widget.contextPage)
                          .updateLikePost(
                              context: widget.contextPage,
                              idPost: widget.postUpdateMini.id!);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.button,
                      border: Border.all(
                        color: theme.button,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.thumb_up_alt_outlined,
                              size: theme.sizeTitle,
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              widget.postUpdateMini.likeQuantity.toString(),

                              // widget.screenComment
                              //     ? post.likeQuantity == 0
                              //         ? widget.postUpdateMini.likeQuantity
                              //             .toString()
                              //         : post.likeQuantity.toString()
                              //     : widget.postUpdateMini.likeQuantity
                              //         .toString(),
                              style: TextStyle(
                                fontSize: theme.sizeTitle,
                                letterSpacing: theme.letterSpacingText,
                                color: theme.title,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (!widget.screenComment) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentsPostUpdate(
                            postUpdateMini: widget.postUpdateMini,
                            screenUser: widget.screenUser,
                            contextPage: widget.contextPage,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.button,
                      border: Border.all(
                        color: theme.button,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.messenger_outline,
                              size: theme.sizeTitle,
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              widget.postUpdateMini.commentQuantity.toString(),

                              // widget.screenComment
                              //     ? post.commentQuantity == 0
                              //         ? widget
                              //             .postUpdateMini.commentQuantity
                              //             .toString()
                              //         : post.commentQuantity.toString()
                              //     : widget.postUpdateMini.commentQuantity
                              //         .toString(),
                              style: TextStyle(
                                fontSize: theme.sizeTitle,
                                letterSpacing: theme.letterSpacingText,
                                color: theme.title,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
            ],
          ),
          const SizedBox(
            height: 16.0,
          ),
        ],
      );
    });
  }
}

Widget entity(
    {required PostUpdateMini postUpdateMini,
    required BuildContext context,
    required bool screenUser}) {
  return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (postUpdateMini.user!.id !=
                    ScopedModel.of<ProfileModel>(context).userMini.id &&
                !screenUser) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => User(userMini: postUpdateMini.user!)),
              );
            }
          },
          child: Text(
            postUpdateMini.user!.name,
            // +
            // " " +
            // LanguageModel().entitiesCategories[
            //         ConvertToEnum.convertTypeEntityToValue(
            //             typeEntity: widget.postUpdateMini
            //                 .entity!.typeEntity)]
            //     [widget.postUpdateMini.category] +
            // " " +
            // widget.postUpdateMini.entity!.name,
            style: TextStyle(
              fontSize: theme.sizeText,
              letterSpacing: theme.letterSpacingText,
              color: theme.title,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Text(" "),
        Text(
          LanguageModel().entitiesCategoriesPost[
                  ConvertToEnum.convertTypeEntityToValue(
                      typeEntity: postUpdateMini.entity!.typeEntity)]
              [postUpdateMini.category],
          style: TextStyle(
            fontSize: theme.sizeText,
            letterSpacing: theme.letterSpacingText,
            color: theme.title,
            fontWeight: FontWeight.normal,
          ),
        ),
        const Text(" "),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Entity(
                        entityMini: postUpdateMini.entity!,
                        datasheetIsOpen: false)));
          },
          child: Text(
            postUpdateMini.entity!.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: theme.sizeText,
              letterSpacing: theme.letterSpacingText,
              color: theme.title,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Text(
        //   " • ",
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     fontSize: 14,
        //     letterSpacing: 1.0,
        //     color: theme.subtitle,
        //     fontWeight: FontWeight.normal,
        //   ),
        // ),
        Text(
          " • " +
              ConvertDate.convertToDatePost(release: postUpdateMini.release!),
          style: TextStyle(
            fontSize: theme.sizeText,
            letterSpacing: theme.letterSpacingText,
            color: theme.title,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  });
}

Widget season(
    {required PostUpdateMini postUpdateMini,
    required BuildContext context,
    required bool screenUser}) {
  return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (postUpdateMini.user!.id !=
                    ScopedModel.of<ProfileModel>(context).userMini.id &&
                !screenUser) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => User(userMini: postUpdateMini.user!)),
              );
            }
          },
          child: Text(
            postUpdateMini.user!.name,
            // +
            // " " +
            // LanguageModel().entitiesCategories[
            //         ConvertToEnum.convertTypeEntityToValue(
            //             typeEntity: widget.postUpdateMini
            //                 .entity!.typeEntity)]
            //     [widget.postUpdateMini.category] +
            // " " +
            // widget.postUpdateMini.entity!.name,
            style: TextStyle(
              fontSize: theme.sizeText,
              letterSpacing: theme.letterSpacingText,
              color: theme.title,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Text(" "),
        Text(
          LanguageModel().entitiesCategoriesPost[
                  ConvertToEnum.convertTypeEntityToValue(
                      typeEntity: postUpdateMini.season!.entity.typeEntity)]
              [postUpdateMini.category],
          style: TextStyle(
            fontSize: theme.sizeText,
            letterSpacing: theme.letterSpacingText,
            color: theme.title,
            fontWeight: FontWeight.normal,
          ),
        ),
        const Text(" "),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Season(
                          seasonMini: postUpdateMini.season!,
                        )));
          },
          child: Text(
            postUpdateMini.season!.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: theme.sizeText,
              letterSpacing: theme.letterSpacingText,
              color: theme.title,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          " • ",
          style: TextStyle(
            fontSize: theme.sizeText,
            letterSpacing: theme.letterSpacingText,
            color: theme.title,
            fontWeight: FontWeight.normal,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Entity(
                        entityMini: postUpdateMini.season!.entity,
                        datasheetIsOpen: false)));
          },
          child: Text(
            postUpdateMini.season!.entity.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: theme.sizeText,
              letterSpacing: theme.letterSpacingText,
              color: theme.title,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Text(
        //   " • ",
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     fontSize: 14,
        //     letterSpacing: 1.0,
        //     color: theme.subtitle,
        //     fontWeight: FontWeight.normal,
        //   ),
        // ),
        Text(
          " • " +
              ConvertDate.convertToDatePost(release: postUpdateMini.release!),
          style: TextStyle(
            fontSize: theme.sizeText,
            letterSpacing: theme.letterSpacingText,
            color: theme.title,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  });
}

Widget episode(
    {required PostUpdateMini postUpdateMini,
    required BuildContext context,
    required bool screenUser}) {
  return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (postUpdateMini.user!.id !=
                    ScopedModel.of<ProfileModel>(context).userMini.id &&
                !screenUser) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => User(userMini: postUpdateMini.user!)),
              );
            }
          },
          child: Text(
            postUpdateMini.user!.name,
            // +
            // " " +
            // LanguageModel().entitiesCategories[
            //         ConvertToEnum.convertTypeEntityToValue(
            //             typeEntity: widget.postUpdateMini
            //                 .entity!.typeEntity)]
            //     [widget.postUpdateMini.category] +
            // " " +
            // widget.postUpdateMini.entity!.name,
            style: TextStyle(
              fontSize: theme.sizeText,
              letterSpacing: theme.letterSpacingText,
              color: theme.title,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Text(" "),
        Text(
          LanguageModel().entitiesCategoriesPost[
              ConvertToEnum.convertTypeEntityToValue(
                  typeEntity: postUpdateMini.episode!.season.entity
                      .typeEntity)][postUpdateMini.category],
          style: TextStyle(
            fontSize: theme.sizeText,
            letterSpacing: theme.letterSpacingText,
            color: theme.title,
            fontWeight: FontWeight.normal,
          ),
        ),
        const Text(" "),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Episode(
                          episodeMini: postUpdateMini.episode!,
                        )));
          },
          child: Text(
            postUpdateMini.episode!.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: theme.sizeText,
              letterSpacing: theme.letterSpacingText,
              color: theme.title,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          " • ",
          style: TextStyle(
            fontSize: theme.sizeText,
            letterSpacing: theme.letterSpacingText,
            color: theme.title,
            fontWeight: FontWeight.normal,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Season(
                          seasonMini: postUpdateMini.episode!.season,
                        )));
          },
          child: Text(
            postUpdateMini.episode!.season.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: theme.sizeText,
              letterSpacing: theme.letterSpacingText,
              color: theme.title,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          " • ",
          style: TextStyle(
            fontSize: theme.sizeText,
            letterSpacing: theme.letterSpacingText,
            color: theme.title,
            fontWeight: FontWeight.normal,
          ),
        ),
        const Text(" "),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Entity(
                        entityMini: postUpdateMini.episode!.season.entity,
                        datasheetIsOpen: false)));
          },
          child: Text(
            postUpdateMini.episode!.season.entity.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: theme.sizeText,
              letterSpacing: theme.letterSpacingText,
              color: theme.title,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Text(
        //   " • ",
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     fontSize: 14,
        //     letterSpacing: 1.0,
        //     color: theme.subtitle,
        //     fontWeight: FontWeight.normal,
        //   ),
        // ),
        Text(
          " • " +
              ConvertDate.convertToDatePost(release: postUpdateMini.release!),
          style: TextStyle(
            fontSize: theme.sizeText,
            letterSpacing: theme.letterSpacingText,
            color: theme.title,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  });
}

Widget entityImage({
  required PostUpdateMini postUpdateMini,
  required BuildContext contextPage,
  required bool screenComment,
  required bool screenUser,
}) {
  return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
    return postUpdateMini.entity!.image != null
        ? GestureDetector(
            onTap: () {
              if (!screenComment) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentsPostUpdate(
                      postUpdateMini: postUpdateMini,
                      screenUser: screenUser,
                      contextPage: contextPage,
                    ),
                  ),
                );
              }
            },
            child: Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              height: (MediaQuery.of(context).size.width / 16) * 9,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: theme.shadow,
                image: DecorationImage(
                  image: NetworkImage(postUpdateMini.entity!.image!),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              if (!screenComment) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentsPostUpdate(
                      postUpdateMini: postUpdateMini,
                      screenUser: screenUser,
                      contextPage: contextPage,
                    ),
                  ),
                );
              }
            },
            child: Container(
              color: theme.shadow,
              height: (MediaQuery.of(context).size.width / 16) * 9,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 100,
                  color: theme.emphasis,
                ),
              ),
            ),
          );
  });
}

Widget seasonImage({
  required PostUpdateMini postUpdateMini,
  required BuildContext contextPage,
  required bool screenComment,
  required bool screenUser,
}) {
  return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
    return postUpdateMini.season!.image != null
        ? GestureDetector(
            onTap: () {
              if (!screenComment) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentsPostUpdate(
                      postUpdateMini: postUpdateMini,
                      screenUser: screenUser,
                      contextPage: contextPage,
                    ),
                  ),
                );
              }
            },
            child: Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              height: (MediaQuery.of(context).size.width / 16) * 9,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: theme.shadow,
                image: DecorationImage(
                  image: NetworkImage(postUpdateMini.season!.image!),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              if (!screenComment) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentsPostUpdate(
                      postUpdateMini: postUpdateMini,
                      screenUser: screenUser,
                      contextPage: contextPage,
                    ),
                  ),
                );
              }
            },
            child: Container(
              color: theme.shadow,
              height: (MediaQuery.of(context).size.width / 16) * 9,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 100,
                  color: theme.emphasis,
                ),
              ),
            ),
          );
  });
}

Widget episodeImage({
  required PostUpdateMini postUpdateMini,
  required BuildContext contextPage,
  required bool screenComment,
  required bool screenUser,
}) {
  return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
    return postUpdateMini.episode!.image != null
        ? GestureDetector(
            onTap: () {
              if (!screenComment) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentsPostUpdate(
                      postUpdateMini: postUpdateMini,
                      screenUser: screenUser,
                      contextPage: contextPage,
                    ),
                  ),
                );
              }
            },
            child: Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              height: (MediaQuery.of(context).size.width / 16) * 9,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: theme.shadow,
                image: DecorationImage(
                  image: NetworkImage(postUpdateMini.episode!.image!),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              if (!screenComment) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentsPostUpdate(
                      postUpdateMini: postUpdateMini,
                      screenUser: screenUser,
                      contextPage: contextPage,
                    ),
                  ),
                );
              }
            },
            child: Container(
              color: theme.shadow,
              height: (MediaQuery.of(context).size.width / 16) * 9,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 100,
                  color: theme.emphasis,
                ),
              ),
            ),
          );
  });
}
