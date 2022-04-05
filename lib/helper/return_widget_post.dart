import 'package:flutter/material.dart';
import 'package:social_network_application/entities/mini_dto/post_talk_group_mini.dart';
import 'package:social_network_application/entities/mini_dto/post_talk_mini.dart';
import 'package:social_network_application/entities/mini_dto/post_update_mini.dart';
import 'package:social_network_application/enuns/type_post.dart';
import 'package:social_network_application/enuns/type_post_visibility.dart';
import 'package:social_network_application/widgets/post/talk_group_post_widget.dart';
import 'package:social_network_application/widgets/post/talk_user_post_widget.dart';
import 'package:social_network_application/widgets/post/update_post_widget_2.dart';

class ReturnWidgetPost {
  static returnPostWidget({
    required Map post,
    required bool screenComment,
    required BuildContext contextPage,
    required bool screenUser,
    required bool screenGroup,
  }) {
    switch (post["typePostVisibility"]) {
      case TypePostVisibility.USER:
        // ignore: avoid_print
        switch (post["typePost"]) {
          case TypePost.UPDATE:
            return UpdatePostWidget2(
              postUpdateMini: PostUpdateMini.fromMap(map: post),
              screenComment: screenComment,
              screenUser: screenUser,
              contextPage: contextPage,
              screenGroup: screenGroup,
            );
          case TypePost.TALK_USER:
            return TalkUserPostWidget(
              post: PostTalkMini.fromMap(map: post),
              screenComment: screenComment,
              screenUser: screenUser,
              contextPage: contextPage,
              screenGroup: screenGroup,
            );
          default:
            return Container();
        }

      case TypePostVisibility.GROUP:
        // ignore: avoid_print
        switch (post["typePost"]) {
          case TypePost.TALK_GROUP:
            return TalkGroupPostWidget(
              post: PostTalkGroupMini.fromMap(map: post),
              screenComment: screenComment,
              screenUser: screenUser,
              contextPage: contextPage,
              screenGroup: screenGroup,
            );
          default:
            return Container();
        }
      default:
        return Container();
    }
  }
}
