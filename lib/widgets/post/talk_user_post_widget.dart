import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/converts/convert_date.dart';
import 'package:social_network_application/entities/mini_dto/post_talk_mini.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/scoped_model/user_model.dart';
import 'package:social_network_application/view/objects/user.dart';
import 'package:social_network_application/view/post/likes_post.dart';
import 'package:social_network_application/converts/convert_like_names.dart';
import 'package:social_network_application/view/tabs/profile.dart';

// ignore: must_be_immutable
class TalkUserPostWidget extends StatefulWidget {
  PostTalkMini post;
  bool screenComment;
  bool screenUser;
  bool screenGroup;
  bool screenProfile;
  BuildContext contextPage;
  TalkUserPostWidget({required this.post, required this.screenComment, required this.screenUser, required this.screenGroup, required this.screenProfile, required this.contextPage, Key? key}) : super(key: key);

  @override
  _TalkUserPostWidgetState createState() => _TalkUserPostWidgetState();
}

class _TalkUserPostWidgetState extends State<TalkUserPostWidget> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Column(
        children: [
          const SizedBox(
            height: 16.0,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => CommentsPostUpdate2(postUpdateMini: widget.postUpdateMini, screenUser: widget.screenUser, contextPage: context),
              //   ),
              // );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 4.0,
                ),

                //image profile user

                widget.post.author!.imageProfile != null
                    ? GestureDetector(
                        onTap: () {
                          if (widget.post.author!.id != ScopedModel.of<ProfileModel>(context).userMini.id && !widget.screenUser) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => User(userMini: widget.post.author!)),
                            );
                          } else if (widget.post.author!.id == ScopedModel.of<ProfileModel>(context).userMini.id && !widget.screenProfile) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
                          }
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.post.author!.imageProfile!),
                          radius: 30.0,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (widget.post.author!.id != ScopedModel.of<ProfileModel>(context).userMini.id && !widget.screenUser) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => User(userMini: widget.post.author!)),
                            );
                          } else if (widget.post.author!.id == ScopedModel.of<ProfileModel>(context).userMini.id && !widget.screenProfile) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
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

                //**image profile user */

                const SizedBox(
                  width: 8.0,
                ),

                // ignore: sized_box_for_whitespace
                Container(
                  //color: Colors.transparent,
                  // decoration: BoxDecoration(
                  //   //color: theme.button,
                  //   border: Border.all(
                  //     color: theme.button,
                  //   ),
                  //   borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  // ),
                  width: MediaQuery.of(context).size.width - 84,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (widget.post.author!.id != ScopedModel.of<ProfileModel>(context).userMini.id && !widget.screenUser) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => User(userMini: widget.post.author!)),
                              );
                            } else if (widget.post.author!.id == ScopedModel.of<ProfileModel>(context).userMini.id && !widget.screenProfile) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
                            }
                          },
                          child: Text(
                            widget.post.author!.name,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: theme.sizeText,
                              letterSpacing: theme.letterSpacingText,
                              color: theme.title,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     widget.post.level == Level.ENTITY
                        //         ? Expanded(
                        //             child: entity(
                        //               context: context,
                        //               postUpdateMini: widget.postUpdateMini,
                        //               screenUser: widget.screenUser,
                        //             ),
                        //           )
                        //         : Container(),
                        //     //  widget.postUpdateMini.level == Level.SEASON
                        //     //     ? Expanded(
                        //     //         child: season(
                        //     //           postUpdateMini: widget.postUpdateMini,
                        //     //           context: context,
                        //     //           screenUser: widget.screenUser,
                        //     //         ),
                        //     //       )
                        //     //     : Expanded(
                        //     //         child: episode(
                        //     //           postUpdateMini: widget.postUpdateMini,
                        //     //           context: context,
                        //     //           screenUser: widget.screenUser,
                        //     //         ),
                        //     //       ),
                        //   ],
                        // ),
                        // widget.postUpdateMini.category != 6
                        //     ? Container()
                        //     : Container(
                        //         margin: EdgeInsets.zero,
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Icon(
                        //                 Icons.star,
                        //                 size: 30,
                        //                 color: widget.postUpdateMini.evaluation >= 1 ? Colors.yellow[700] : theme.icon,
                        //               ),
                        //               Icon(
                        //                 Icons.star,
                        //                 size: 30,
                        //                 color: widget.postUpdateMini.evaluation >= 2 ? Colors.yellow[700] : theme.icon,
                        //               ),
                        //               Icon(
                        //                 Icons.star,
                        //                 size: 30,
                        //                 color: widget.postUpdateMini.evaluation >= 3 ? Colors.yellow[700] : theme.icon,
                        //               ),
                        //               Icon(
                        //                 Icons.star,
                        //                 size: 30,
                        //                 color: widget.postUpdateMini.evaluation >= 4 ? Colors.yellow[700] : theme.icon,
                        //               ),
                        //               Icon(
                        //                 Icons.star,
                        //                 size: 30,
                        //                 color: widget.postUpdateMini.evaluation >= 5 ? Colors.yellow[700] : theme.icon,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        // widget.postUpdateMini.category != 6
                        //     ? Container()
                        //     :
                        const SizedBox(
                          height: 2.0,
                        ),
                        !widget.post.spoiler
                            ?
                            //  widget.postUpdateMini.body != null
                            //     ? Theme(
                            //         data: ThemeData().copyWith(dividerColor: Colors.transparent),
                            //         child: ExpansionTile(
                            //           //tilePadding: const EdgeInsets.all(8.0),
                            //           onExpansionChanged: (_) {
                            //             updateMaxLine();
                            //           },
                            //           title: Text(
                            //             widget.postUpdateMini.body!,
                            //             maxLines: maxLine,
                            //             style: TextStyle(
                            //               fontSize: theme.sizeText,
                            //               letterSpacing: theme.letterSpacingText,
                            //               color: theme.title,
                            //               fontWeight: FontWeight.normal,
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     : Container()
                            widget.post.body != null
                                ? Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
                                      child: Text(
                                        widget.post.body!,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
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
                            : Theme(
                                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                                child: ExpansionTile(
                                  tilePadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
                                  title: Text(
                                    widget.post.title!,
                                    style: TextStyle(
                                      fontSize: theme.sizeText,
                                      letterSpacing: theme.letterSpacingText,
                                      color: theme.title,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.0),
                                        child: Text(
                                          widget.post.body!,
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
                              ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        // widget.postUpdateMini.level == Level.ENTITY ? entityImage(postUpdateMini: widget.postUpdateMini, contextPage: widget.contextPage, screenComment: widget.screenComment, screenUser: widget.screenUser) : Container(),
                        // // widget.postUpdateMini.level == Level.SEASON
                        // //     ? seasonImage(postUpdateMini: widget.postUpdateMini, contextPage: widget.contextPage, screenComment: widget.screenComment, screenUser: widget.screenUser)
                        // //     : episodeImage(postUpdateMini: widget.postUpdateMini, contextPage: widget.contextPage, screenComment: widget.screenComment, screenUser: widget.screenUser),
                        // const SizedBox(
                        //   height: 16.0,
                        // ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LikesPost(
                                            idPost: widget.post.id!,
                                          )));
                            },
                            child: ConvertLikeNames.returnLikes(
                              liked: widget.post.liked,
                              likeQuantity: widget.post.likeQuantity,
                              like: widget.post.like,
                              context: context,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 2.0,
                        ),
                        // Divider(
                        //   color: theme.button,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                ConvertDate.convertToDatePost(release: widget.post.release!),
                                style: TextStyle(
                                  fontSize: theme.sizeText,
                                  letterSpacing: theme.letterSpacingTitle,
                                  color: theme.subtitle,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (!widget.screenComment && !widget.screenUser) {
                                  ScopedModel.of<ProfileModel>(context).updateLikePost(context: context, idPost: widget.post.id!);
                                } else if (widget.screenUser && !widget.screenComment) {
                                  ScopedModel.of<UserModel>(widget.contextPage).updateLikePost(context: widget.contextPage, idPost: widget.post.id!);
                                }
                              },
                              child: Container(
                                color: Colors.transparent,
                                // decoration: BoxDecoration(
                                //   color: theme.button,
                                //   border: Border.all(
                                //       color: theme.button,
                                //       ),
                                //   borderRadius: const BorderRadius.all(
                                //       Radius.circular(16.0)),
                                // ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.post.likeQuantity.toString() + " ",

                                          // widget.screenComment
                                          //     ? post.likeQuantity == 0
                                          //         ? widget.postUpdateMini.likeQuantity
                                          //             .toString()
                                          //         : post.likeQuantity.toString()
                                          //     : widget.postUpdateMini.likeQuantity
                                          //         .toString(),
                                          style: TextStyle(
                                            fontSize: theme.sizeText,
                                            letterSpacing: theme.letterSpacingTitle,
                                            color: widget.post.liked ? theme.emphasis : theme.subtitle,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Icon(
                                          Icons.thumb_up_alt_outlined,
                                          size: theme.sizeText,
                                          color: widget.post.liked ? theme.emphasis : theme.subtitle,
                                        ),
                                        // const SizedBox(
                                        //   width: 8.0,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // if (!widget.screenComment) {
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => CommentsPostUpdate2(
                                //         postUpdateMini: widget.post,
                                //         screenUser: widget.screenUser,
                                //         contextPage: widget.contextPage,
                                //       ),
                                //     ),
                                //   );
                                // }
                              },
                              child: Container(
                                color: Colors.transparent,
                                // decoration: BoxDecoration(
                                //   color: theme.button,
                                //   border: Border.all(
                                //       color: theme.button,
                                //       ),
                                //   borderRadius: const BorderRadius.all(
                                //       Radius.circular(16.0)),
                                // ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.post.commentQuantity.toString() + " ",
                                          style: TextStyle(
                                            fontSize: theme.sizeText,
                                            letterSpacing: theme.letterSpacingTitle,
                                            color: theme.subtitle,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Icon(
                                          Icons.messenger_outline,
                                          size: theme.sizeText,
                                          color: theme.subtitle,
                                        ),
                                        // const SizedBox(
                                        //   width: 6.0,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (widget.post.author!.id == ScopedModel.of<ProfileModel>(context).userMini.id) {
                                  ScopedModel.of<ProfileModel>(context).showDeletePostBottomSheet(
                                    context: context,
                                    idPost: widget.post.id!,
                                    screenComment: widget.screenComment,
                                    screenUser: widget.screenUser,
                                    contextPage: widget.contextPage,
                                    screenGroup: widget.screenGroup,
                                  );
                                } else {
                                  ScopedModel.of<ProfileModel>(context).showOptionsPostBottomSheet(
                                    contextAncestor: context,
                                    idPost: widget.post.id!,
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.more_vert_sharp,
                                size: theme.sizeTitle,
                                color: theme.subtitle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 8.0,
                // ),
              ],
            ),
          ),
          // const SizedBox(
          //   height: 16.0,
          // ),
        ],
      );
    });
  }
}
/*
Widget entity({required PostUpdateMini postUpdateMini, required BuildContext context, required bool screenUser}) {
  return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (postUpdateMini.author!.id != ScopedModel.of<ProfileModel>(context).userMini.id && !screenUser) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => User(userMini: postUpdateMini.author!)),
              );
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
            }
          },
          child: Text(
            postUpdateMini.author!.name,
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
          LanguageModel().entitiesCategoriesPost[ConvertToEnum.convertTypeEntityToValue(typeEntity: postUpdateMini.entity!.typeEntity)][postUpdateMini.category],
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => Entity2(entityMini: postUpdateMini.entity!, datasheetIsOpen: false)));
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
        // Text(
        //   " • " +
        //       ConvertDate.convertToDatePost(release: postUpdateMini.release!),
        //   style: TextStyle(
        //     fontSize: theme.sizeText,
        //     letterSpacing: theme.letterSpacingText,
        //     color: theme.title,
        //     fontWeight: FontWeight.normal,
        //   ),
        // ),
      ],
    );
  });
}
*/

/*
Widget season({required PostUpdateMini postUpdateMini, required BuildContext context, required bool screenUser}) {
  return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (postUpdateMini.author!.id != ScopedModel.of<ProfileModel>(context).userMini.id && !screenUser) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => User(userMini: postUpdateMini.author!)),
              );
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
            }
          },
          child: Text(
            postUpdateMini.author!.name,
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
          LanguageModel().entitiesCategoriesPost[ConvertToEnum.convertTypeEntityToValue(typeEntity: postUpdateMini.season!.entity.typeEntity)][postUpdateMini.category],
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => Entity(entityMini: postUpdateMini.season!.entity, datasheetIsOpen: false)));
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
        // Text(
        //   " • " +
        //       ConvertDate.convertToDatePost(release: postUpdateMini.release!),
        //   style: TextStyle(
        //     fontSize: theme.sizeText,
        //     letterSpacing: theme.letterSpacingText,
        //     color: theme.title,
        //     fontWeight: FontWeight.normal,
        //   ),
        // ),
      ],
    );
  });
}

Widget episode({required PostUpdateMini postUpdateMini, required BuildContext context, required bool screenUser}) {
  return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (postUpdateMini.author!.id != ScopedModel.of<ProfileModel>(context).userMini.id && !screenUser) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => User(userMini: postUpdateMini.author!)),
              );
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
            }
          },
          child: Text(
            postUpdateMini.author!.name,
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
          LanguageModel().entitiesCategoriesPost[ConvertToEnum.convertTypeEntityToValue(typeEntity: postUpdateMini.episode!.season.entity.typeEntity)][postUpdateMini.category],
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => Entity(entityMini: postUpdateMini.episode!.season.entity, datasheetIsOpen: false)));
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
        // Text(
        //   " • " +
        //       ConvertDate.convertToDatePost(release: postUpdateMini.release!),
        //   style: TextStyle(
        //     fontSize: theme.sizeText,
        //     letterSpacing: theme.letterSpacingText,
        //     color: theme.title,
        //     fontWeight: FontWeight.normal,
        //   ),
        // ),
      ],
    );
  });
}
*/
/*
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
                    builder: (context) => CommentsPostUpdate2(
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
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
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
                    builder: (context) => CommentsPostUpdate2(
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
*/
/*

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
                    builder: (context) => CommentsPostUpdate2(
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
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
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
                    builder: (context) => CommentsPostUpdate2(
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
                    builder: (context) => CommentsPostUpdate2(
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
                border: Border.all(
                  color: Colors.transparent,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
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
                    builder: (context) => CommentsPostUpdate2(
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
*/
