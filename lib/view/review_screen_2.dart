import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/converts/convert_date.dart';
import 'package:social_network_application/converts/convert_like_names.dart';
import 'package:social_network_application/entities/mini_dto/comment_mini.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/review_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/review/likes_review.dart';
import 'package:social_network_application/view/tabs/profile.dart';

import 'objects/user.dart';

// ignore: must_be_immutable
class ReviewScreen2 extends StatefulWidget {
  String idReview;
  BuildContext contextEntityPage;
  String typeObject;
  ReviewScreen2({required this.idReview, required this.contextEntityPage, required this.typeObject, Key? key}) : super(key: key);

  @override
  _ReviewScreen2State createState() => _ReviewScreen2State();
}

class _ReviewScreen2State extends State<ReviewScreen2> {
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
      return ScopedModel<ReviewModel>(
          model: ReviewModel(
            contextEntityPage: widget.contextEntityPage,
            idReview: widget.idReview,
            typeObject: widget.typeObject,
            contextReviewPage: context,
          ),
          child: ScopedModelDescendant<ReviewModel>(builder: (context, child, review) {
            return Scaffold(
              appBar: AppBar(
                  elevation: 0.0,
                  title: Text(
                    'Review',
                    style: TextStyle(
                      color: theme.title,
                      fontSize: theme.sizeAppBar,
                      letterSpacing: theme.letterSpacingAppBar,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
              body: Stack(
                children: [
                  review.entitySaveMiniIsNull
                      ? Container()
                      : Column(
                          children: [
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                //physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Row(
                                        //mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            width: 8.0,
                                          ),

                                          //**/ first imageProfile

                                          review.entitySaveMini!.user!.imageProfile != null
                                              ? GestureDetector(
                                                  onTap: () {
                                                    if (review.entitySaveMini!.user!.id != ScopedModel.of<ProfileModel>(context).userMini.id) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => User(userMini: review.entitySaveMini!.user!)),
                                                      );
                                                    } else {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => const Profile()),
                                                      );
                                                    }
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundImage: NetworkImage(review.entitySaveMini!.user!.imageProfile!),
                                                    radius: 30.0,
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    if (review.entitySaveMini!.user!.id != ScopedModel.of<ProfileModel>(context).userMini.id) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => User(userMini: review.entitySaveMini!.user!)),
                                                      );
                                                    } else {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => const Profile()),
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
                                          //**/ and imageProfile

                                          //** first name */
                                          const SizedBox(
                                            width: 8.0,
                                          ),

                                          // ignore: sized_box_for_whitespace
                                          Container(
                                            width: MediaQuery.of(context).size.width - 84,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (review.entitySaveMini!.user!.id != ScopedModel.of<ProfileModel>(context).userMini.id) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => User(userMini: review.entitySaveMini!.user!)),
                                                      );
                                                    } else {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => const Profile()),
                                                      );
                                                    }
                                                  },
                                                  child: Text(
                                                    review.entitySaveMini!.user!.name,
                                                    style: TextStyle(
                                                      fontSize: theme.sizeText,
                                                      letterSpacing: theme.letterSpacingText,
                                                      color: theme.title,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height: 8.0,
                                                ),
                                                !review.entitySaveMini!.rated
                                                    ? Container()
                                                    : Container(
                                                        margin: EdgeInsets.zero,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                size: 30,
                                                                color: review.entitySaveMini!.evaluation! >= 1 ? Colors.yellow[700] : theme.icon,
                                                              ),
                                                              Icon(
                                                                Icons.star,
                                                                size: 30,
                                                                color: review.entitySaveMini!.evaluation! >= 2 ? Colors.yellow[700] : theme.icon,
                                                              ),
                                                              Icon(
                                                                Icons.star,
                                                                size: 30,
                                                                color: review.entitySaveMini!.evaluation! >= 3 ? Colors.yellow[700] : theme.icon,
                                                              ),
                                                              Icon(
                                                                Icons.star,
                                                                size: 30,
                                                                color: review.entitySaveMini!.evaluation! >= 4 ? Colors.yellow[700] : theme.icon,
                                                              ),
                                                              Icon(
                                                                Icons.star,
                                                                size: 30,
                                                                color: review.entitySaveMini!.evaluation! >= 5 ? Colors.yellow[700] : theme.icon,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                !review.entitySaveMini!.spoiler
                                                    ? Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.0),
                                                          child: Text(
                                                            review.entitySaveMini!.review!,
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
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 0.0),
                                                              child: Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Text(
                                                                  review.entitySaveMini!.review!,
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
                                                  height: 16.0,
                                                ),

                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => LikesReview(idReview: widget.idReview),
                                                        ),
                                                      );
                                                    },
                                                    child: ConvertLikeNames.returnLikes(
                                                      liked: review.entitySaveMini!.liked,
                                                      likeQuantity: review.entitySaveMini!.likeQuantity,
                                                      like: review.entitySaveMini!.like,
                                                      context: context,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 16.0,
                                                ),

                                                //first row comments and likes

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    review.entitySaveMini!.release == null
                                                        ? Container()
                                                        : Text(
                                                            ConvertDate.convertToDatePost(release: review.entitySaveMini!.release!) + " ",
                                                            style: TextStyle(
                                                              fontSize: theme.sizeText,
                                                              letterSpacing: theme.letterSpacingText,
                                                              color: theme.subtitle,
                                                              fontWeight: FontWeight.normal,
                                                            ),
                                                          ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        review.updateLikeReview(
                                                          idReview: review.entitySaveMini!.id,
                                                          contextEntityPage: widget.contextEntityPage,
                                                          contextReviewPage: context,
                                                        );
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            review.entitySaveMini!.likeQuantity.toString() + " ",
                                                            style: TextStyle(
                                                              fontSize: theme.sizeText,
                                                              letterSpacing: theme.letterSpacingText,
                                                              color: review.entitySaveMini!.liked ? theme.emphasis : theme.subtitle,
                                                              fontWeight: FontWeight.normal,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.thumb_up_alt_outlined,
                                                            size: theme.sizeText,
                                                            color: review.entitySaveMini!.liked ? theme.emphasis : theme.subtitle,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          review.entitySaveMini!.commentQuantity.toString() + " ",
                                                          style: TextStyle(
                                                            fontSize: theme.sizeText,
                                                            letterSpacing: theme.letterSpacingText,
                                                            color: theme.subtitle,
                                                            fontWeight: FontWeight.normal,
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.messenger_outline,
                                                          size: theme.sizeText,
                                                          color: theme.subtitle,
                                                        ),
                                                      ],
                                                    ),
                                                    Icon(
                                                      Icons.more_vert_sharp,
                                                      size: theme.sizeText,
                                                      color: Colors.transparent,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      //and row comments and likes
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  // Divider(
                                  //   height: 10.0,
                                  //   thickness: 10.0,
                                  //   color: theme.shadow,
                                  // ),
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
                                      itemCount: review.comments.length,
                                      itemBuilder: (contextListBuilder, index) {
                                        return CommentWidget(
                                          commentMini: review.comments[index],
                                          idReview: review.entitySaveMini!.id,
                                          contextEntityPage: widget.contextEntityPage,
                                          contextReviewPage: context,
                                        );
                                      }),
                                ],
                              ),
                            ),

                            //first comment

                            Container(
                              width: MediaQuery.of(context).size.width,
                              color: ScopedModel.of<ThemeModel>(context).button,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextField(
                                  maxLength: 280,
                                  controller: review.controller,
                                  minLines: 1,
                                  maxLines: 5,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    label: const Text("comment"),
                                    //border: OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        if (review.controller.text.isNotEmpty) {
                                          review.addCommentPost(
                                            idEntitySave: review.entitySaveMini!.id,
                                            body: review.controller.text,
                                            contextEntityPage: widget.contextEntityPage,
                                            contextReviewPage: context,
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
                  review.load
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
  String idReview;
  BuildContext contextReviewPage;
  BuildContext contextEntityPage;
  CommentWidget({required this.commentMini, required this.idReview, required this.contextReviewPage, required this.contextEntityPage, Key? key}) : super(key: key);

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
            Column(
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  width: MediaQuery.of(context).size.width - 84,
                  // decoration: BoxDecoration(
                  //   color: ScopedModel.of<ThemeModel>(context).button,
                  //   border: Border.all(
                  //     color: ScopedModel.of<ThemeModel>(context).button,
                  //   ),
                  //   borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width - 84,
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
                              ScopedModel.of<ReviewModel>(context).updateLikeComment(context: context, idComment: widget.commentMini.id, idReview: widget.idReview);
                            },
                            icon: Icon(
                              Icons.thumb_up_alt_outlined,
                              size: theme.sizeText,
                              color: widget.commentMini.liked ? theme.emphasis : theme.subtitle,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (widget.commentMini.author.id == ScopedModel.of<ProfileModel>(context).userMini.id) {
                            ScopedModel.of<ReviewModel>(widget.contextReviewPage).showDeleteCommentBottomSheet(
                              contextCommentPage: context,
                              idReview: widget.idReview,
                              idComment: widget.commentMini.id,
                              contextPage: widget.contextReviewPage,
                            );
                          } else {
                            ScopedModel.of<ProfileModel>(context).showOptionsCommentBottomSheet(
                              contextAncestor: context,
                              idComment: widget.commentMini.id,
                            );
                          }
                        },
                        icon: Icon(
                          Icons.more_vert_sharp,
                          size: theme.sizeText,
                          color: theme.subtitle,
                        ),
                      ),
                      Icon(
                        Icons.more_vert_sharp,
                        size: theme.sizeText,
                        color: Colors.transparent,
                      ),
                    ],
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
