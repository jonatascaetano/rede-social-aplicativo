import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/likes_review_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/post/user_mini_like_post.dart';

// ignore: must_be_immutable
class LikesReview extends StatefulWidget {
  String idReview;
  LikesReview({required this.idReview, Key? key}) : super(key: key);

  @override
  _LikesReviewState createState() => _LikesReviewState();
}

class _LikesReviewState extends State<LikesReview> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<LikeReviewModel>(
        model: LikeReviewModel(idReview: widget.idReview, context: context),
        child: ScopedModelDescendant<LikeReviewModel>(
            builder: (context, child, likes) {
          return ScopedModelDescendant<ThemeModel>(
              builder: (context, child, theme) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: Text(
                  'Likes',
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
                  likes.likeReviewIsNull
                      ? Container()
                      : ListView.builder(
                          itemCount: likes.users.length,
                          itemBuilder: (context, index) {
                            return UserMiniLikePost(
                                userMini: likes.users[index]);
                          }),
                  likes.load
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
          });
        }));
  }
}
