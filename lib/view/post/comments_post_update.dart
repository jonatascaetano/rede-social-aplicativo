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
import 'package:social_network_application/view/objects/entity.dart';
import 'package:social_network_application/view/objects/episode.dart';
import 'package:social_network_application/view/objects/season.dart';
import 'package:social_network_application/view/objects/user.dart';

// ignore: must_be_immutable
class CommentsPostUpdate extends StatefulWidget {
  PostUpdateMini postUpdateMini;
  bool screenUser;
  BuildContext contextPage;
  CommentsPostUpdate(
      {required this.postUpdateMini,
      required this.screenUser,
      required this.contextPage,
      Key? key})
      : super(key: key);

  @override
  _CommentsPostUpdateState createState() => _CommentsPostUpdateState();
}

class _CommentsPostUpdateState extends State<CommentsPostUpdate> {
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
          child: ScopedModelDescendant<CommentModel>(
              builder: (context, child, comment) {
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
                                        //mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          widget.postUpdateMini.author!
                                                      .imageProfile !=
                                                  null
                                              ? GestureDetector(
                                                  onTap: () {
                                                    if (widget.postUpdateMini
                                                            .author!.id !=
                                                        ScopedModel.of<
                                                                    ProfileModel>(
                                                                context)
                                                            .userMini
                                                            .id) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => User(
                                                                userMini: widget
                                                                    .postUpdateMini
                                                                    .author!)),
                                                      );
                                                    }
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(widget
                                                            .postUpdateMini
                                                            .author!
                                                            .imageProfile!),
                                                    radius: 30.0,
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    if (widget.postUpdateMini
                                                            .author!.id !=
                                                        ScopedModel.of<
                                                                    ProfileModel>(
                                                                context)
                                                            .userMini
                                                            .id) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => User(
                                                                userMini: widget
                                                                    .postUpdateMini
                                                                    .author!)),
                                                      );
                                                    }
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        theme.shadow,
                                                    child: Icon(
                                                      Icons.image,
                                                      color: theme.emphasis,
                                                    ),
                                                    radius: 30.0,
                                                  ),
                                                ),
                                          const SizedBox(
                                            width: 4.0,
                                          ),
                                          Expanded(
                                              child: widget.postUpdateMini
                                                          .level ==
                                                      Level.ENTITY
                                                  ? entity(
                                                      context: context,
                                                      postUpdateMini:
                                                          widget.postUpdateMini,
                                                      screenUser:
                                                          widget.screenUser,
                                                    )
                                                  : widget.postUpdateMini
                                                              .level ==
                                                          Level.SEASON
                                                      ? season(
                                                          postUpdateMini: widget
                                                              .postUpdateMini,
                                                          context: context,
                                                          screenUser:
                                                              widget.screenUser,
                                                        )
                                                      : episode(
                                                          postUpdateMini: widget
                                                              .postUpdateMini,
                                                          context: context,
                                                          screenUser:
                                                              widget.screenUser,
                                                        )),
                                          const SizedBox(
                                            width: 4.0,
                                          ),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () async {
                                              if (widget.postUpdateMini.author!
                                                      .id ==
                                                  ScopedModel.of<ProfileModel>(
                                                          context)
                                                      .userMini
                                                      .id) {
                                                comment
                                                    .showDeletePostBottomSheet(
                                                  idPost:
                                                      widget.postUpdateMini.id!,
                                                  screenComment: true,
                                                  screenUser: widget.screenUser,
                                                  contextPage:
                                                      widget.contextPage,
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
                                                ScopedModel.of<ProfileModel>(
                                                        widget.contextPage)
                                                    .showOptionsPostBottomSheet(
                                                  contextAncestor: context,
                                                  idPost:
                                                      widget.postUpdateMini.id!,
                                                );
                                              }
                                            },
                                            icon: Icon(
                                              Icons.more_vert_sharp,
                                              size: 21,
                                              color: ScopedModel.of<ThemeModel>(
                                                      context)
                                                  .subtitle,
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    size: 50,
                                                    color: widget.postUpdateMini
                                                                .evaluation >=
                                                            1
                                                        ? Colors.yellow[700]
                                                        : theme.icon,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 50,
                                                    color: widget.postUpdateMini
                                                                .evaluation >=
                                                            2
                                                        ? Colors.yellow[700]
                                                        : theme.icon,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 50,
                                                    color: widget.postUpdateMini
                                                                .evaluation >=
                                                            3
                                                        ? Colors.yellow[700]
                                                        : theme.icon,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 50,
                                                    color: widget.postUpdateMini
                                                                .evaluation >=
                                                            4
                                                        ? Colors.yellow[700]
                                                        : theme.icon,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 50,
                                                    color: widget.postUpdateMini
                                                                .evaluation >=
                                                            5
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
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 2.0,
                                                        horizontal: 8.0),
                                                    child: Text(
                                                      widget
                                                          .postUpdateMini.body!,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize:
                                                            theme.sizeText,
                                                        letterSpacing: theme
                                                            .letterSpacingText,
                                                        color: theme.title,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container()
                                          : ExpansionTile(
                                              tilePadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2.0,
                                                      horizontal: 8.0),
                                              title: Text(
                                                'Spoiler',
                                                style: TextStyle(
                                                  fontSize: theme.sizeText,
                                                  letterSpacing:
                                                      theme.letterSpacingText,
                                                  color: theme.title,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 2.0,
                                                      horizontal: 8.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      widget
                                                          .postUpdateMini.body!,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontSize:
                                                            theme.sizeText,
                                                        letterSpacing: theme
                                                            .letterSpacingText,
                                                        color: theme.title,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      widget.postUpdateMini.level ==
                                              Level.ENTITY
                                          ? entityImage(
                                              postUpdateMini:
                                                  widget.postUpdateMini,
                                              contextPage: widget.contextPage,
                                              //screenComment: widget.screenComment,
                                              screenUser: widget.screenUser)
                                          : widget.postUpdateMini.level ==
                                                  Level.SEASON
                                              ? seasonImage(
                                                  postUpdateMini:
                                                      widget.postUpdateMini,
                                                  contextPage:
                                                      widget.contextPage,
                                                  //screenComment: widget.screenComment,
                                                  screenUser: widget.screenUser)
                                              : episodeImage(
                                                  postUpdateMini:
                                                      widget.postUpdateMini,
                                                  contextPage:
                                                      widget.contextPage,
                                                  //screenComment: widget.screenComment,
                                                  screenUser:
                                                      widget.screenUser),
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
                                      const SizedBox(
                                        height: 16.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                comment.updateLikePost(
                                                  context: widget.contextPage,
                                                  idPost:
                                                      widget.postUpdateMini.id!,
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: theme.button,
                                                  border: Border.all(
                                                    color: theme.button,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              16.0)),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .thumb_up_alt_outlined,
                                                          size: theme.sizeTitle,
                                                          color: comment
                                                                  .postUpdateMini
                                                                  .liked
                                                              ? theme.emphasis
                                                              : theme.title,
                                                        ),
                                                        const SizedBox(
                                                          width: 6.0,
                                                        ),
                                                        Text(
                                                          comment.likeQuantity
                                                              .toString(),

                                                          // widget.screenComment
                                                          //     ? post.likeQuantity == 0
                                                          //         ? widget.postUpdateMini.likeQuantity
                                                          //             .toString()
                                                          //         : post.likeQuantity.toString()
                                                          //     : widget.postUpdateMini.likeQuantity
                                                          //         .toString(),
                                                          style: TextStyle(
                                                            fontSize:
                                                                theme.sizeTitle,
                                                            letterSpacing: theme
                                                                .letterSpacingText,
                                                            color: comment
                                                                    .postUpdateMini
                                                                    .liked
                                                                ? theme.emphasis
                                                                : theme.title,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
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
                                              onTap: () {},
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: theme.button,
                                                  border: Border.all(
                                                    color: theme.button,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              16.0)),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .messenger_outline,
                                                          size: theme.sizeTitle,
                                                        ),
                                                        const SizedBox(
                                                          width: 6.0,
                                                        ),
                                                        Text(
                                                          comment
                                                              .commentQuantity
                                                              .toString(),

                                                          // widget.screenComment
                                                          //     ? post.commentQuantity == 0
                                                          //         ? widget
                                                          //             .postUpdateMini.commentQuantity
                                                          //             .toString()
                                                          //         : post.commentQuantity.toString()
                                                          //     : widget.postUpdateMini.commentQuantity
                                                          //         .toString(),
                                                          style: TextStyle(
                                                            fontSize:
                                                                theme.sizeTitle,
                                                            letterSpacing: theme
                                                                .letterSpacingText,
                                                            color: theme.title,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
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
                                  ),
                                  Divider(
                                    color: theme.button,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                              child: TextField(
                                controller: comment.controller,
                                minLines: 1,
                                maxLines: 5,
                                keyboardType: TextInputType.emailAddress,
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
                                        FocusScopeNode currentFocus =
                                            FocusScope.of(context);

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
  CommentWidget(
      {required this.commentMini,
      required this.idPost,
      required this.screenUser,
      required this.contextPage,
      Key? key})
      : super(key: key);

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
                ? CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.commentMini.author.imageProfile!),
                    radius: 30.0,
                  )
                : CircleAvatar(
                    backgroundColor: ScopedModel.of<ThemeModel>(context).shadow,
                    child: Icon(
                      Icons.image,
                      color: ScopedModel.of<ThemeModel>(context).emphasis,
                    ),
                    radius: 30.0,
                  ),
            const SizedBox(
              width: 8.0,
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 80,
                  decoration: BoxDecoration(
                    color: ScopedModel.of<ThemeModel>(context).button,
                    border: Border.all(
                      color: ScopedModel.of<ThemeModel>(context).button,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => User(
                                        userMini: widget.commentMini.author)));
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
                    width: MediaQuery.of(context).size.width - 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          ConvertDate.convertToDatePost(
                                  release: widget.commentMini.release) +
                              " • ",
                          style: TextStyle(
                            fontSize: theme.sizeText,
                            letterSpacing: theme.letterSpacingText,
                            color: ScopedModel.of<ThemeModel>(context).subtitle,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          widget.commentMini.likeQuantity.toString(),
                          style: TextStyle(
                            fontSize: theme.sizeText,
                            letterSpacing: theme.letterSpacingText,
                            color: widget.commentMini.liked
                                ? theme.emphasis
                                : theme.title,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            ScopedModel.of<CommentModel>(context)
                                .updateLikeComment(
                              context: context,
                              idComment: widget.commentMini.id,
                              idPost: widget.idPost,
                            );
                          },
                          icon: Icon(
                            Icons.thumb_up_alt_outlined,
                            size: theme.sizeTitle,
                            color: widget.commentMini.liked
                                ? theme.emphasis
                                : theme.title,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (widget.commentMini.author.id ==
                                ScopedModel.of<ProfileModel>(context)
                                    .userMini
                                    .id) {
                              ScopedModel.of<CommentModel>(context)
                                  .showDeleteCommentBottomSheet(
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
                              ScopedModel.of<ProfileModel>(context)
                                  .showOptionsCommentBottomSheet(
                                contextAncestor: context,
                                idComment: widget.commentMini.id,
                              );
                            }
                          },
                          icon: Icon(
                            Icons.more_vert_sharp,
                            size: theme.sizeTitle,
                            color: ScopedModel.of<ThemeModel>(context).subtitle,
                          ),
                        ),
                      ],
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
            if (postUpdateMini.author!.id !=
                ScopedModel.of<ProfileModel>(context).userMini.id) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        User(userMini: postUpdateMini.author!)),
              );
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
            if (postUpdateMini.author!.id !=
                ScopedModel.of<ProfileModel>(context).userMini.id) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        User(userMini: postUpdateMini.author!)),
              );
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
            if (postUpdateMini.author!.id !=
                ScopedModel.of<ProfileModel>(context).userMini.id) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        User(userMini: postUpdateMini.author!)),
              );
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
