import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/comment_mini.dart';
import 'package:social_network_application/entities/mini_dto/post_update_mini.dart';
import 'package:social_network_application/scoped_model/comment_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

// ignore: must_be_immutable
class CommentPostWidget extends StatefulWidget {
  PostUpdateMini postUpdateMini;
  CommentPostWidget({required this.postUpdateMini, Key? key}) : super(key: key);

  @override
  _CommentPostWidgetState createState() => _CommentPostWidgetState();
}

class _CommentPostWidgetState extends State<CommentPostWidget> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<CommentModel>(
          model:
              CommentModel(context: context, idPost: widget.postUpdateMini.id!),
          child: ScopedModelDescendant<CommentModel>(
              builder: (context, child, comment) {
            return Scaffold(
              body: comment.comments.isEmpty
                  ? Container()
                  : Column(
                      children: comment.comments
                          .map((e) => CommentWidget(commentMini: e))
                          .toList(),
                    ),
            );
          }));
    });
  }
}

// ignore: must_be_immutable
class CommentWidget extends StatefulWidget {
  CommentMini commentMini;
  CommentWidget({required this.commentMini, Key? key}) : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(widget.commentMini.body),
    );
  }
}
