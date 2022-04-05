import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/converts/convert_date.dart';
import 'package:social_network_application/converts/convert_to_enum.dart';
import 'package:social_network_application/entities/mini_dto/comment_mini.dart';
import 'package:social_network_application/entities/mini_dto/post_update_mini.dart';
import 'package:social_network_application/enuns/level.dart';
import 'package:social_network_application/scoped_model/comment_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/objects/entity2.dart';
import 'package:social_network_application/view/objects/user.dart';
import 'package:social_network_application/converts/convert_like_names.dart';
import 'package:social_network_application/view/tabs/profile.dart';

import 'likes_post.dart';

// ignore: must_be_immutable
class CommentsPostUpdate2 extends StatefulWidget {
  PostUpdateMini postUpdateMini;
  bool screenUser;
  BuildContext contextPage;
  CommentsPostUpdate2({required this.postUpdateMini, required this.screenUser, required this.contextPage, Key? key}) : super(key: key);

  @override
  _CommentsPostUpdate2State createState() => _CommentsPostUpdate2State();
}

class _CommentsPostUpdate2State extends State<CommentsPostUpdate2> {
  void handleEvent(AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        // ignore: avoid_print
        print('Novo $adType Ad carregado!');
        break;
      case AdmobAdEvent.opened:
        // ignore: avoid_print
        print('Admob $adType Ad aberto!');
        break;
      case AdmobAdEvent.closed:
        // ignore: avoid_print
        print('Admob $adType Ad fechado!');
        break;
      case AdmobAdEvent.failedToLoad:
        // ignore: avoid_print
        print('Admob $adType falhou ao carregar. :(');
        break;
      default:
    }
  }

  AdmobBanner getBanner(AdmobBannerSize size) {
    return AdmobBanner(
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      adSize: size,
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        // handleEvent(event, args!, 'Banner');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<CommentModel>(
          model: CommentModel(
            context: context,
            idPost: widget.postUpdateMini.id!,
            comments: widget.postUpdateMini.commentQuantity,
            likes: widget.postUpdateMini.likeQuantity,
          ),
          child: ScopedModelDescendant<CommentModel>(builder: (context, child, comment) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: Text(
                  'Post of ' + widget.postUpdateMini.author!.name,
                  style: TextStyle(
                    color: theme.title,
                    fontSize: theme.sizeAppBar,
                    letterSpacing: theme.letterSpacingAppBar,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              body: Stack(
                children: [
                  comment.postUpdateMiniIsNull
                      ? Container()
                      : Column(
                          children: [
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            width: 4.0,
                                          ),
                                          widget.postUpdateMini.author!.imageProfile != null
                                              ? GestureDetector(
                                                  onTap: () {
                                                    if (widget.postUpdateMini.author!.id != ScopedModel.of<ProfileModel>(context).userMini.id) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => User(userMini: widget.postUpdateMini.author!)),
                                                      );
                                                    } else {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
                                                    }
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundImage: NetworkImage(widget.postUpdateMini.author!.imageProfile!),
                                                    radius: 30.0,
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    if (widget.postUpdateMini.author!.id != ScopedModel.of<ProfileModel>(context).userMini.id) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => User(userMini: widget.postUpdateMini.author!)),
                                                      );
                                                    } else {
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
                                          const SizedBox(
                                            width: 8.0,
                                          ),

                                          //init
                                          // ignore: sized_box_for_whitespace
                                          Container(
                                            // //color: Colors.transparent,
                                            // decoration: BoxDecoration(
                                            //   //color: theme.button,
                                            //   border: Border.all(
                                            //     color: theme.button,
                                            //   ),
                                            //   borderRadius:
                                            //       const BorderRadius.all(
                                            //           Radius.circular(16.0)),
                                            // ),
                                            width: MediaQuery.of(context).size.width - 84,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      widget.postUpdateMini.level == Level.ENTITY
                                                          ? Expanded(
                                                              child: entity(
                                                                context: context,
                                                                postUpdateMini: widget.postUpdateMini,
                                                                screenUser: widget.screenUser,
                                                              ),
                                                            )
                                                          : Container(),
                                                      // widget.postUpdateMini.level == Level.SEASON
                                                      //     ? Expanded(
                                                      //         child: season(
                                                      //           postUpdateMini: widget.postUpdateMini,
                                                      //           context: context,
                                                      //           screenUser: widget.screenUser,
                                                      //         ),
                                                      //       )
                                                      //     : Expanded(
                                                      //         child: episode(
                                                      //           postUpdateMini: widget.postUpdateMini,
                                                      //           context: context,
                                                      //           screenUser: widget.screenUser,
                                                      //         ),
                                                      //       ),
                                                    ],
                                                  ),
                                                  widget.postUpdateMini.category != 6
                                                      ? Container()
                                                      : Container(
                                                          margin: EdgeInsets.zero,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  size: 30,
                                                                  color: widget.postUpdateMini.evaluation >= 1 ? Colors.yellow[700] : theme.icon,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  size: 30,
                                                                  color: widget.postUpdateMini.evaluation >= 2 ? Colors.yellow[700] : theme.icon,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  size: 30,
                                                                  color: widget.postUpdateMini.evaluation >= 3 ? Colors.yellow[700] : theme.icon,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  size: 30,
                                                                  color: widget.postUpdateMini.evaluation >= 4 ? Colors.yellow[700] : theme.icon,
                                                                ),
                                                                Icon(
                                                                  Icons.star,
                                                                  size: 30,
                                                                  color: widget.postUpdateMini.evaluation >= 5 ? Colors.yellow[700] : theme.icon,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                  const SizedBox(
                                                    height: 2.0,
                                                  ),
                                                  !widget.postUpdateMini.spoiler
                                                      ? widget.postUpdateMini.body != null
                                                          ? Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Padding(
                                                                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
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
                                                      : Theme(
                                                          data: ThemeData().copyWith(dividerColor: Colors.transparent),
                                                          child: ExpansionTile(
                                                            tilePadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
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
                                                              Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
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
                                                        ),
                                                  const SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  widget.postUpdateMini.level == Level.ENTITY
                                                      ? entityImage(
                                                          postUpdateMini: widget.postUpdateMini,
                                                          contextPage: widget.contextPage,
                                                          //screenComment: widget.screenComment,
                                                          screenUser: widget.screenUser)
                                                      : Container(),
                                                  // widget.postUpdateMini.level == Level.SEASON
                                                  //     ? seasonImage(
                                                  //         postUpdateMini: widget.postUpdateMini,
                                                  //         contextPage: widget.contextPage,
                                                  //         //screenComment: widget.screenComment,
                                                  //         screenUser: widget.screenUser)
                                                  //     : episodeImage(
                                                  //         postUpdateMini: widget.postUpdateMini,
                                                  //         contextPage: widget.contextPage,
                                                  //         //screenComment: widget.screenComment,
                                                  //         screenUser: widget.screenUser),
                                                  const SizedBox(
                                                    height: 16.0,
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => LikesPost(
                                                                      idPost: widget.postUpdateMini.id!,
                                                                    )));
                                                      },
                                                      child: ConvertLikeNames.returnLikes(
                                                        liked: comment.postUpdateMini.liked,
                                                        likeQuantity: comment.postUpdateMini.likeQuantity,
                                                        like: comment.postUpdateMini.like,
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
                                                          ConvertDate.convertToDatePost(release: widget.postUpdateMini.release!),
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
                                                          comment.updateLikePost(
                                                            context: widget.contextPage,
                                                            idPost: widget.postUpdateMini.id!,
                                                          );
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
                                                                    comment.postUpdateMini.likeQuantity.toString() + " ",

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
                                                                      color: comment.postUpdateMini.liked ? theme.emphasis : theme.subtitle,
                                                                      fontWeight: FontWeight.normal,
                                                                    ),
                                                                  ),
                                                                  Icon(
                                                                    Icons.thumb_up_alt_outlined,
                                                                    size: theme.sizeText,
                                                                    color: comment.postUpdateMini.liked ? theme.emphasis : theme.subtitle,
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
                                                          //         postUpdateMini: widget.postUpdateMini,
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
                                                                    comment.postUpdateMini.commentQuantity.toString() + " ",
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
                                                        onPressed: () async {
                                                          if (widget.postUpdateMini.author!.id == ScopedModel.of<ProfileModel>(context).userMini.id) {
                                                            comment.showDeletePostBottomSheet(
                                                              idPost: widget.postUpdateMini.id!,
                                                              screenComment: true,
                                                              screenUser: widget.screenUser,
                                                              contextPage: widget.contextPage,
                                                              contextCommentPage: context,
                                                            );
                                                            // ScaffoldMessenger.of(context)
                                                            //     .showSnackBar(
                                                            //   SnackBar(
                                                            //     backgroundColor:
                                                            //         ScopedModel.of<ThemeModel>(
                                                            //                 context)
                                                            //             .background,
                                                            //     content: Text('delete post?',
                                                            //         style: TextStyle(
                                                            //           color: ScopedModel.of<
                                                            //                   ThemeModel>(context)
                                                            //               .subtitle,
                                                            //         )),
                                                            //     action: SnackBarAction(
                                                            //         label: 'yes',
                                                            //         textColor: ScopedModel.of<
                                                            //                 ThemeModel>(context)
                                                            //             .emphasis,
                                                            //         onPressed: () {
                                                            //           comment.removePost(
                                                            //             context:
                                                            //                 widget.contextPage,
                                                            //             idPost: widget
                                                            //                 .postUpdateMini.id!,
                                                            //             contextPage:
                                                            //                 widget.contextPage,
                                                            //             screenUser:
                                                            //                 widget.screenUser,
                                                            //           );
                                                            //         }),
                                                            //   ),
                                                            // );
                                                          } else {
                                                            ScopedModel.of<ProfileModel>(widget.contextPage).showOptionsPostBottomSheet(
                                                              contextAncestor: context,
                                                              idPost: widget.postUpdateMini.id!,
                                                            );
                                                          }
                                                        },
                                                        icon: Icon(
                                                          Icons.more_vert_sharp,
                                                          size: theme.sizeText,
                                                          color: theme.subtitle,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // Expanded(
                                          //     child: widget.postUpdateMini
                                          //                 .level ==
                                          //             Level.ENTITY
                                          //         ? entity(
                                          //             context: context,
                                          //             postUpdateMini:
                                          //                 widget.postUpdateMini,
                                          //             screenUser:
                                          //                 widget.screenUser,
                                          //           )
                                          //         : widget.postUpdateMini
                                          //                     .level ==
                                          //                 Level.SEASON
                                          //             ? season(
                                          //                 postUpdateMini: widget
                                          //                     .postUpdateMini,
                                          //                 context: context,
                                          //                 screenUser:
                                          //                     widget.screenUser,
                                          //               )
                                          //             : episode(
                                          //                 postUpdateMini: widget
                                          //                     .postUpdateMini,
                                          //                 context: context,
                                          //                 screenUser:
                                          //                     widget.screenUser,
                                          //               ),),
                                          // const SizedBox(
                                          //   width: 4.0,
                                          // ),
                                          // IconButton(
                                          //   padding: EdgeInsets.zero,
                                          //   onPressed: () async {
                                          //     if (widget.postUpdateMini.author!
                                          //             .id ==
                                          //         ScopedModel.of<ProfileModel>(
                                          //                 context)
                                          //             .userMini
                                          //             .id) {
                                          //       comment
                                          //           .showDeletePostBottomSheet(
                                          //         idPost:
                                          //             widget.postUpdateMini.id!,
                                          //         screenComment: true,
                                          //         screenUser: widget.screenUser,
                                          //         contextPage:
                                          //             widget.contextPage,
                                          //         contextCommentPage: context,
                                          //       );
                                          //       // ScaffoldMessenger.of(context)
                                          //       //     .showSnackBar(
                                          //       //   SnackBar(
                                          //       //     backgroundColor:
                                          //       //         ScopedModel.of<ThemeModel>(
                                          //       //                 context)
                                          //       //             .background,
                                          //       //     content: Text('delete post?',
                                          //       //         style: TextStyle(
                                          //       //           color: ScopedModel.of<
                                          //       //                   ThemeModel>(context)
                                          //       //               .subtitle,
                                          //       //         )),
                                          //       //     action: SnackBarAction(
                                          //       //         label: 'yes',
                                          //       //         textColor: ScopedModel.of<
                                          //       //                 ThemeModel>(context)
                                          //       //             .emphasis,
                                          //       //         onPressed: () {
                                          //       //           comment.removePost(
                                          //       //             context:
                                          //       //                 widget.contextPage,
                                          //       //             idPost: widget
                                          //       //                 .postUpdateMini.id!,
                                          //       //             contextPage:
                                          //       //                 widget.contextPage,
                                          //       //             screenUser:
                                          //       //                 widget.screenUser,
                                          //       //           );
                                          //       //         }),
                                          //       //   ),
                                          //       // );
                                          //     } else {
                                          //       ScopedModel.of<ProfileModel>(
                                          //               widget.contextPage)
                                          //           .showOptionsPostBottomSheet(
                                          //         contextAncestor: context,
                                          //         idPost:
                                          //             widget.postUpdateMini.id!,
                                          //       );
                                          //     }
                                          //   },
                                          //   icon: Icon(
                                          //     Icons.more_vert_sharp,
                                          //     size: 21,
                                          //     color: ScopedModel.of<ThemeModel>(
                                          //             context)
                                          //         .subtitle,
                                          //   ),
                                          // ),
                                          // const SizedBox(
                                          //   width: 8.0,
                                          // ),
                                        ],
                                      ),

                                      // const SizedBox(
                                      //   height: 8.0,
                                      // ),
                                      // widget.postUpdateMini.category != 6
                                      //     ? Container()
                                      //     : Container(
                                      //         margin: EdgeInsets.zero,
                                      //         padding:
                                      //             const EdgeInsets.symmetric(
                                      //                 vertical: 4.0),
                                      //         child: Row(
                                      //           mainAxisAlignment:
                                      //               MainAxisAlignment.center,
                                      //           children: [
                                      //             Padding(
                                      //               padding:
                                      //                   const EdgeInsets.all(
                                      //                       8.0),
                                      //               child: Icon(
                                      //                 Icons.star,
                                      //                 size: 40,
                                      //                 color: widget
                                      //                             .postUpdateMini
                                      //                             .evaluation >=
                                      //                         1
                                      //                     ? Colors.yellow[700]
                                      //                     : theme.icon,
                                      //               ),
                                      //             ),
                                      //             Padding(
                                      //               padding:
                                      //                   const EdgeInsets.all(
                                      //                       8.0),
                                      //               child: Icon(
                                      //                 Icons.star,
                                      //                 size: 40,
                                      //                 color: widget
                                      //                             .postUpdateMini
                                      //                             .evaluation >=
                                      //                         2
                                      //                     ? Colors.yellow[700]
                                      //                     : theme.icon,
                                      //               ),
                                      //             ),
                                      //             Padding(
                                      //               padding:
                                      //                   const EdgeInsets.all(
                                      //                       8.0),
                                      //               child: Icon(
                                      //                 Icons.star,
                                      //                 size: 40,
                                      //                 color: widget
                                      //                             .postUpdateMini
                                      //                             .evaluation >=
                                      //                         3
                                      //                     ? Colors.yellow[700]
                                      //                     : theme.icon,
                                      //               ),
                                      //             ),
                                      //             Padding(
                                      //               padding:
                                      //                   const EdgeInsets.all(
                                      //                       8.0),
                                      //               child: Icon(
                                      //                 Icons.star,
                                      //                 size: 40,
                                      //                 color: widget
                                      //                             .postUpdateMini
                                      //                             .evaluation >=
                                      //                         4
                                      //                     ? Colors.yellow[700]
                                      //                     : theme.icon,
                                      //               ),
                                      //             ),
                                      //             Padding(
                                      //               padding:
                                      //                   const EdgeInsets.all(
                                      //                       8.0),
                                      //               child: Icon(
                                      //                 Icons.star,
                                      //                 size: 40,
                                      //                 color: widget
                                      //                             .postUpdateMini
                                      //                             .evaluation >=
                                      //                         5
                                      //                     ? Colors.yellow[700]
                                      //                     : theme.icon,
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ),
                                      // widget.postUpdateMini.category != 6
                                      //     ? Container()
                                      //     : const SizedBox(
                                      //         height: 8.0,
                                      //       ),
                                      // !widget.postUpdateMini.spoiler
                                      //     ? widget.postUpdateMini.body != null
                                      //         ? Align(
                                      //             alignment:
                                      //                 Alignment.centerLeft,
                                      //             child: Padding(
                                      //               padding: const EdgeInsets
                                      //                       .symmetric(
                                      //                   vertical: 2.0,
                                      //                   horizontal: 8.0),
                                      //               child: Text(
                                      //                 widget
                                      //                     .postUpdateMini.body!,
                                      //                 textAlign: TextAlign.left,
                                      //                 style: TextStyle(
                                      //                   fontSize:
                                      //                       theme.sizeText,
                                      //                   letterSpacing: theme
                                      //                       .letterSpacingText,
                                      //                   color: theme.title,
                                      //                   fontWeight:
                                      //                       FontWeight.normal,
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           )
                                      //         : Container()
                                      //     : ExpansionTile(
                                      //         tilePadding:
                                      //             const EdgeInsets.symmetric(
                                      //                 vertical: 2.0,
                                      //                 horizontal: 8.0),
                                      //         title: Text(
                                      //           'Spoiler',
                                      //           style: TextStyle(
                                      //             fontSize: theme.sizeText,
                                      //             letterSpacing:
                                      //                 theme.letterSpacingText,
                                      //             color: theme.title,
                                      //             fontWeight: FontWeight.normal,
                                      //           ),
                                      //         ),
                                      //         children: [
                                      //           Padding(
                                      //             padding: const EdgeInsets
                                      //                     .symmetric(
                                      //                 vertical: 2.0,
                                      //                 horizontal: 8.0),
                                      //             child: Align(
                                      //               alignment:
                                      //                   Alignment.centerLeft,
                                      //               child: Text(
                                      //                 widget
                                      //                     .postUpdateMini.body!,
                                      //                 textAlign: TextAlign.left,
                                      //                 style: TextStyle(
                                      //                   fontSize:
                                      //                       theme.sizeText,
                                      //                   letterSpacing: theme
                                      //                       .letterSpacingText,
                                      //                   color: theme.title,
                                      //                   fontWeight:
                                      //                       FontWeight.normal,
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       ),
                                      // const SizedBox(
                                      //   height: 8.0,
                                      // ),
                                      // widget.postUpdateMini.level ==
                                      //         Level.ENTITY
                                      //     ? entityImage(
                                      //         postUpdateMini:
                                      //             widget.postUpdateMini,
                                      //         contextPage: widget.contextPage,
                                      //         //screenComment: widget.screenComment,
                                      //         screenUser: widget.screenUser)
                                      //     : widget.postUpdateMini.level ==
                                      //             Level.SEASON
                                      //         ? seasonImage(
                                      //             postUpdateMini:
                                      //                 widget.postUpdateMini,
                                      //             contextPage:
                                      //                 widget.contextPage,
                                      //             //screenComment: widget.screenComment,
                                      //             screenUser: widget.screenUser)
                                      //         : episodeImage(
                                      //             postUpdateMini:
                                      //                 widget.postUpdateMini,
                                      //             contextPage:
                                      //                 widget.contextPage,
                                      //             //screenComment: widget.screenComment,
                                      //             screenUser:
                                      //                 widget.screenUser),
                                      /*
                                    widget.postUpdateMini.entity!.image != null
                                        ? GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              margin: EdgeInsets.zero,
                                              padding: EdgeInsets.zero,
                                              height: (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      16) *
                                                  9,
                                              width:
                                                  MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                color: theme.shadow,
                                                image: DecorationImage(
                                                  image: NetworkImage(widget
                                                      .postUpdateMini
                                                      .entity!
                                                      .image!),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              color: theme.shadow,
                                              height: (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      16) *
                                                  9,
                                              width:
                                                  MediaQuery.of(context).size.width,
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

                                      // const SizedBox(
                                      //   height: 8.0,
                                      // ),
                                      // Align(
                                      //   alignment: Alignment.centerLeft,
                                      //   child: GestureDetector(
                                      //     onTap: () {
                                      //       Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: (context) =>
                                      //                   LikesPost(
                                      //                     idPost: widget
                                      //                         .postUpdateMini
                                      //                         .id!,
                                      //                   )));
                                      //     },
                                      //     child: ConvertLikeNames.returnLikes(
                                      //       liked: widget.postUpdateMini.liked,
                                      //       likeQuantity: widget
                                      //           .postUpdateMini.likeQuantity,
                                      //       like: widget.postUpdateMini.like,
                                      //       context: context,
                                      //     ),
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   height: 8.0,
                                      // ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceAround,
                                      //   children: [
                                      //     const SizedBox(
                                      //       width: 8.0,
                                      //     ),
                                      //     Expanded(
                                      //       flex: 1,
                                      //       child: GestureDetector(
                                      //         onTap: () {
                                      //           comment.updateLikePost(
                                      //             context: widget.contextPage,
                                      //             idPost:
                                      //                 widget.postUpdateMini.id!,
                                      //           );
                                      //         },
                                      //         child: Container(
                                      //           decoration: BoxDecoration(
                                      //             color: theme.button,
                                      //             border: Border.all(
                                      //               color: theme.button,
                                      //             ),
                                      //             borderRadius:
                                      //                 const BorderRadius.all(
                                      //                     Radius.circular(
                                      //                         16.0)),
                                      //           ),
                                      //           child: Padding(
                                      //             padding:
                                      //                 const EdgeInsets.all(8.0),
                                      //             child: Center(
                                      //               child: Row(
                                      //                 mainAxisAlignment:
                                      //                     MainAxisAlignment
                                      //                         .center,
                                      //                 children: [
                                      //                   Icon(
                                      //                     Icons
                                      //                         .thumb_up_alt_outlined,
                                      //                     size: theme.sizeTitle,
                                      //                     color: comment
                                      //                             .postUpdateMini
                                      //                             .liked
                                      //                         ? theme.emphasis
                                      //                         : theme.title,
                                      //                   ),
                                      //                   const SizedBox(
                                      //                     width: 6.0,
                                      //                   ),
                                      //                   Text(
                                      //                     comment.likeQuantity
                                      //                         .toString(),

                                      //                     // widget.screenComment
                                      //                     //     ? post.likeQuantity == 0
                                      //                     //         ? widget.postUpdateMini.likeQuantity
                                      //                     //             .toString()
                                      //                     //         : post.likeQuantity.toString()
                                      //                     //     : widget.postUpdateMini.likeQuantity
                                      //                     //         .toString(),
                                      //                     style: TextStyle(
                                      //                       fontSize:
                                      //                           theme.sizeTitle,
                                      //                       letterSpacing: theme
                                      //                           .letterSpacingText,
                                      //                       color: comment
                                      //                               .postUpdateMini
                                      //                               .liked
                                      //                           ? theme.emphasis
                                      //                           : theme.title,
                                      //                       fontWeight:
                                      //                           FontWeight
                                      //                               .normal,
                                      //                     ),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     const SizedBox(
                                      //       width: 8.0,
                                      //     ),
                                      //     Expanded(
                                      //       flex: 1,
                                      //       child: GestureDetector(
                                      //         onTap: () {},
                                      //         child: Container(
                                      //           decoration: BoxDecoration(
                                      //             color: theme.button,
                                      //             border: Border.all(
                                      //               color: theme.button,
                                      //             ),
                                      //             borderRadius:
                                      //                 const BorderRadius.all(
                                      //                     Radius.circular(
                                      //                         16.0)),
                                      //           ),
                                      //           child: Padding(
                                      //             padding:
                                      //                 const EdgeInsets.all(8.0),
                                      //             child: Center(
                                      //               child: Row(
                                      //                 mainAxisAlignment:
                                      //                     MainAxisAlignment
                                      //                         .center,
                                      //                 children: [
                                      //                   Icon(
                                      //                     Icons
                                      //                         .messenger_outline,
                                      //                     size: theme.sizeTitle,
                                      //                   ),
                                      //                   const SizedBox(
                                      //                     width: 6.0,
                                      //                   ),
                                      //                   Text(
                                      //                     comment
                                      //                         .commentQuantity
                                      //                         .toString(),

                                      //                     // widget.screenComment
                                      //                     //     ? post.commentQuantity == 0
                                      //                     //         ? widget
                                      //                     //             .postUpdateMini.commentQuantity
                                      //                     //             .toString()
                                      //                     //         : post.commentQuantity.toString()
                                      //                     //     : widget.postUpdateMini.commentQuantity
                                      //                     //         .toString(),
                                      //                     style: TextStyle(
                                      //                       fontSize:
                                      //                           theme.sizeTitle,
                                      //                       letterSpacing: theme
                                      //                           .letterSpacingText,
                                      //                       color: theme.title,
                                      //                       fontWeight:
                                      //                           FontWeight
                                      //                               .normal,
                                      //                     ),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     const SizedBox(
                                      //       width: 8.0,
                                      //     ),
                                      //   ],
                                      // ),
                                      // const SizedBox(
                                      //   height: 16.0,
                                      // ),
                                    ],
                                  ),
                                  // Divider(
                                  //   height: 10.0,
                                  //   thickness: 10.0,
                                  //   color: theme.shadow,
                                  // ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: theme.shadow,
                                    ),
                                    child: getBanner(AdmobBannerSize.MEDIUM_RECTANGLE),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: comment.comments.length,
                                      itemBuilder: (context, index) {
                                        return CommentWidget(
                                          commentMini: comment.comments[index],
                                          idPost: widget.postUpdateMini.id!,
                                          contextPage: widget.contextPage,
                                          screenUser: widget.screenUser,
                                        );
                                      }),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              color: ScopedModel.of<ThemeModel>(context).button,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextField(
                                  maxLength: 280,
                                  controller: comment.controller,
                                  minLines: 1,
                                  maxLines: 5,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    label: const Text("comment"),
                                    //border: OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        if (comment.controller.text.isNotEmpty) {
                                          comment.addCommentPost(
                                            idPost: widget.postUpdateMini.id!,
                                            context: widget.contextPage,
                                            body: comment.controller.text,
                                            screenUser: widget.screenUser,
                                          );
                                          FocusScopeNode currentFocus = FocusScope.of(context);

                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.send),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  comment.load
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
              ),
            );
          }));
    });
  }
}

// ignore: must_be_immutable
class CommentWidget extends StatefulWidget {
  CommentMini commentMini;
  String idPost;
  bool screenUser;
  BuildContext contextPage;
  CommentWidget({required this.commentMini, required this.idPost, required this.screenUser, required this.contextPage, Key? key}) : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 8.0,
            ),
            widget.commentMini.author.imageProfile != null
                ? GestureDetector(
                    onTap: () {
                      if (widget.commentMini.author.id != ScopedModel.of<ProfileModel>(context).userMini.id) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => User(userMini: widget.commentMini.author)));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
                      }
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.commentMini.author.imageProfile!),
                      radius: 30.0,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      if (widget.commentMini.author.id != ScopedModel.of<ProfileModel>(context).userMini.id) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => User(userMini: widget.commentMini.author)));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: ScopedModel.of<ThemeModel>(context).shadow,
                      child: Icon(
                        Icons.image,
                        color: ScopedModel.of<ThemeModel>(context).emphasis,
                      ),
                      radius: 30.0,
                    ),
                  ),
            const SizedBox(
              width: 8.0,
            ),
            // ignore: sized_box_for_whitespace
            Column(
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  width: MediaQuery.of(context).size.width - 84,
                  // decoration: BoxDecoration(
                  //   //color: ScopedModel.of<ThemeModel>(context).button,
                  //   border: Border.all(
                  //     color: ScopedModel.of<ThemeModel>(context).button,
                  //   ),
                  //   borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (widget.commentMini.author.id != ScopedModel.of<ProfileModel>(context).userMini.id) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => User(userMini: widget.commentMini.author)));
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
                            }
                          },
                          child: Text(
                            widget.commentMini.author.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: theme.sizeText,
                              letterSpacing: theme.letterSpacingText,
                              color: ScopedModel.of<ThemeModel>(context).title,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          widget.commentMini.body,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: theme.sizeText,
                            letterSpacing: theme.letterSpacingText,
                            color: ScopedModel.of<ThemeModel>(context).title,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 84,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.commentMini.release == null
                              ? Container()
                              : Text(
                                  ConvertDate.convertToDatePost(release: widget.commentMini.release!),
                                  style: TextStyle(
                                    fontSize: theme.sizeText,
                                    letterSpacing: theme.letterSpacingText,
                                    color: theme.subtitle,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                          // const SizedBox(
                          //   width: 8.0,
                          // ),
                          Row(
                            children: [
                              Text(
                                widget.commentMini.likeQuantity.toString(),
                                style: TextStyle(
                                  fontSize: theme.sizeText,
                                  letterSpacing: theme.letterSpacingText,
                                  color: widget.commentMini.liked ? theme.emphasis : theme.subtitle,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  ScopedModel.of<CommentModel>(context).updateLikeComment(
                                    context: context,
                                    idComment: widget.commentMini.id,
                                    idPost: widget.idPost,
                                  );
                                },
                                icon: Icon(
                                  Icons.thumb_up_alt_outlined,
                                  size: theme.sizeTitle,
                                  color: widget.commentMini.liked ? theme.emphasis : theme.subtitle,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (widget.commentMini.author.id == ScopedModel.of<ProfileModel>(context).userMini.id) {
                                ScopedModel.of<CommentModel>(context).showDeleteCommentBottomSheet(
                                  contextCommentPage: context,
                                  idPost: widget.idPost,
                                  idComment: widget.commentMini.id,
                                  screenComment: true,
                                  screenUser: widget.screenUser,
                                  contextPage: widget.contextPage,
                                );
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     backgroundColor:
                                //         ScopedModel.of<ThemeModel>(context)
                                //             .background,
                                //     content: Text('delete comment?',
                                //         style: TextStyle(
                                //           color:
                                //               ScopedModel.of<ThemeModel>(context)
                                //                   .subtitle,
                                //         )),
                                //     action: SnackBarAction(
                                //         label: 'yes',
                                //         textColor:
                                //             ScopedModel.of<ThemeModel>(context)
                                //                 .emphasis,
                                //         onPressed: () {
                                //           ScopedModel.of<CommentModel>(context)
                                //               .removeCommentPost(
                                //             context: widget.contextPage,
                                //             idComment: widget.commentMini.id,
                                //             idPost: widget.idPost,
                                //             screenUser: widget.screenUser,
                                //           );
                                //         }),
                                //   ),
                                // );

                              } else {
                                ScopedModel.of<ProfileModel>(context).showOptionsCommentBottomSheet(
                                  contextAncestor: context,
                                  idComment: widget.commentMini.id,
                                );
                              }
                            },
                            icon: Icon(
                              Icons.more_vert_sharp,
                              size: theme.sizeTitle,
                              color: theme.subtitle,
                            ),
                          ),
                          Icon(
                            Icons.more_vert_sharp,
                            size: theme.sizeTitle,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

Widget entity({required PostUpdateMini postUpdateMini, required BuildContext context, required bool screenUser}) {
  return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (postUpdateMini.author!.id != ScopedModel.of<ProfileModel>(context).userMini.id) {
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

/*

Widget season({required PostUpdateMini postUpdateMini, required BuildContext context, required bool screenUser}) {
  return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (postUpdateMini.author!.id != ScopedModel.of<ProfileModel>(context).userMini.id) {
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
            if (postUpdateMini.author!.id != ScopedModel.of<ProfileModel>(context).userMini.id) {
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

Widget entityImage({
  required PostUpdateMini postUpdateMini,
  required BuildContext contextPage,
  //required bool screenComment,
  required bool screenUser,
}) {
  return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
    return postUpdateMini.entity!.image != null
        ? GestureDetector(
            onTap: () {
              // if (!screenComment) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => CommentsPostUpdate(
              //         postUpdateMini: postUpdateMini,
              //         screenUser: screenUser,
              //         contextPage: contextPage,
              //       ),
              //     ),
              //   );
              // }
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
              // if (!screenComment) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => CommentsPostUpdate(
              //         postUpdateMini: postUpdateMini,
              //         screenUser: screenUser,
              //         contextPage: contextPage,
              //       ),
              //     ),
              //   );
              // }
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

/*

Widget seasonImage({
  required PostUpdateMini postUpdateMini,
  required BuildContext contextPage,
  //required bool screenComment,
  required bool screenUser,
}) {
  return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
    return postUpdateMini.season!.image != null
        ? GestureDetector(
            onTap: () {
              // if (!screenComment) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => CommentsPostUpdate(
              //         postUpdateMini: postUpdateMini,
              //         screenUser: screenUser,
              //         contextPage: contextPage,
              //       ),
              //     ),
              //   );
              // }
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
              // if (!screenComment) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => CommentsPostUpdate(
              //         postUpdateMini: postUpdateMini,
              //         screenUser: screenUser,
              //         contextPage: contextPage,
              //       ),
              //     ),
              //   );
              // }
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
  //required bool screenComment,
  required bool screenUser,
}) {
  return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
    return postUpdateMini.episode!.image != null
        ? GestureDetector(
            onTap: () {
              // if (!screenComment) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => CommentsPostUpdate(
              //         postUpdateMini: postUpdateMini,
              //         screenUser: screenUser,
              //         contextPage: contextPage,
              //       ),
              //     ),
              //   );
              // }
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
              // if (!screenComment) {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => CommentsPostUpdate(
              //         postUpdateMini: postUpdateMini,
              //         screenUser: screenUser,
              //         contextPage: contextPage,
              //       ),
              //     ),
              //   );
              // }
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