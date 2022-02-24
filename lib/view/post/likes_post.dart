import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/likes_post_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/post/user_mini_like_post.dart';

// ignore: must_be_immutable
class LikesPost extends StatefulWidget {
  String idPost;
  LikesPost({required this.idPost, Key? key}) : super(key: key);

  @override
  _LikesPostState createState() => _LikesPostState();
}

class _LikesPostState extends State<LikesPost> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<LikePostModel>(
        model: LikePostModel(idPost: widget.idPost, context: context),
        child: ScopedModelDescendant<LikePostModel>(
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
                  likes.likePostIsNull
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
