import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/converts/convert_date.dart';
import 'package:social_network_application/entities/mini_dto/comment_mini.dart';
import 'package:social_network_application/entities/mini_dto/post_update_mini.dart';
import 'package:social_network_application/scoped_model/comment_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/post/update_post_entity_widget.dart';

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
          model:
              CommentModel(context: context, idPost: widget.postUpdateMini.id!),
          child: ScopedModelDescendant<CommentModel>(
              builder: (context, child, comment) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: Text(
                  'Post of ' + widget.postUpdateMini.user!.name,
                  style: TextStyle(
                    color: theme.title,
                    fontSize: 24.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              body: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            UpdatePostEntityWidget(
                              postUpdateMini: widget.postUpdateMini,
                              screenComment: true,
                              screenUser: widget.screenUser,
                              contextPage: widget.contextPage,
                            ),
                            Divider(
                              color: theme.button,
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: comment.comments.length,
                                itemBuilder: (context, index) {
                                  return CommentWidget(
                                    commentMini: comment.comments[index],
                                    idPost: widget.postUpdateMini.id!,
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
  CommentWidget({required this.commentMini, required this.idPost, Key? key})
      : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.commentMini.user.image != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(widget.commentMini.user.image!),
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
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.commentMini.user.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1.0,
                          color: ScopedModel.of<ThemeModel>(context).title,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        widget.commentMini.body,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1.0,
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
                          fontSize: 16,
                          letterSpacing: 1.0,
                          color: ScopedModel.of<ThemeModel>(context).subtitle,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        widget.commentMini.likeQuantity.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1.0,
                          color: ScopedModel.of<ThemeModel>(context).subtitle,
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
                          size: 16,
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
  }
}
