import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/converts/convert_date.dart';
import 'package:social_network_application/converts/convert_like_names.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';
import 'package:social_network_application/enuns/type_object.dart';
import 'package:social_network_application/scoped_model/entity_model.dart';
import 'package:social_network_application/scoped_model/episode_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/season_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/objects/user.dart';
import 'package:social_network_application/view/review/likes_review.dart';
import 'package:social_network_application/view/review_screen.dart';
import 'package:social_network_application/view/tabs/profile.dart';

// ignore: must_be_immutable
class Reviews2 extends StatefulWidget {
  EntitySaveMini entitySaveMini;
  BuildContext contextAncestor;
  String typeObject;
  Reviews2(
      {required this.entitySaveMini,
      required this.contextAncestor,
      required this.typeObject,
      Key? key})
      : super(key: key);

  @override
  _Reviews2State createState() => _Reviews2State();
}

class _Reviews2State extends State<Reviews2> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReviewScreen(
                idReview: widget.entitySaveMini.id,
                contextAncestor: widget.contextAncestor,
                typeObject: widget.typeObject,
              ),
            ),
          );
        },
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(
              height: 8.0,
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 8.0,
                ),

                //**/ first imageProfile

                widget.entitySaveMini.user!.imageProfile != null
                    ? GestureDetector(
                        onTap: () {
                          if (widget.entitySaveMini.user!.id !=
                              ScopedModel.of<ProfileModel>(context)
                                  .userMini
                                  .id) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => User(
                                      userMini: widget.entitySaveMini.user!)),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Profile()),
                            );
                          }
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              widget.entitySaveMini.user!.imageProfile!),
                          radius: 30.0,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (widget.entitySaveMini.user!.id !=
                              ScopedModel.of<ProfileModel>(context)
                                  .userMini
                                  .id) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => User(
                                      userMini: widget.entitySaveMini.user!)),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Profile()),
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
                  width: 4.0,
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  width: MediaQuery.of(context).size.width - 84,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (widget.entitySaveMini.user!.id !=
                                ScopedModel.of<ProfileModel>(context)
                                    .userMini
                                    .id) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => User(
                                        userMini: widget.entitySaveMini.user!)),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Profile()),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 0.0,
                            ),
                            child: Text(
                              widget.entitySaveMini.user!.name,
                              style: TextStyle(
                                fontSize: theme.sizeText,
                                letterSpacing: theme.letterSpacingText,
                                color: theme.title,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        !widget.entitySaveMini.rated
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 40,
                                      color:
                                          widget.entitySaveMini.evaluation! >= 1
                                              ? Colors.yellow[700]
                                              : theme.icon,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 40,
                                      color:
                                          widget.entitySaveMini.evaluation! >= 2
                                              ? Colors.yellow[700]
                                              : theme.icon,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 40,
                                      color:
                                          widget.entitySaveMini.evaluation! >= 3
                                              ? Colors.yellow[700]
                                              : theme.icon,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 40,
                                      color:
                                          widget.entitySaveMini.evaluation! >= 4
                                              ? Colors.yellow[700]
                                              : theme.icon,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 40,
                                      color:
                                          widget.entitySaveMini.evaluation! >= 5
                                              ? Colors.yellow[700]
                                              : theme.icon,
                                    ),
                                  ],
                                ),
                              ),

                        !widget.entitySaveMini.spoiler
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 0.0),
                                  child: Text(
                                    widget.entitySaveMini.review!,
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
                            : ExpansionTile(
                                tilePadding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 0.0),
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
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        widget.entitySaveMini.review!,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: theme.sizeText,
                                          letterSpacing:
                                              theme.letterSpacingText,
                                          color: theme.title,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                                  builder: (context) => LikesReview(
                                      idReview: widget.entitySaveMini.id),
                                ),
                              );
                            },
                            child: ConvertLikeNames.returnLikes(
                              liked: widget.entitySaveMini.liked,
                              likeQuantity: widget.entitySaveMini.likeQuantity,
                              like: widget.entitySaveMini.like,
                              context: context,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 8.0,
                        ),

                        //first row comments and likes

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widget.entitySaveMini.release == null
                                ? Container()
                                : Text(
                                    ConvertDate.convertToDatePost(
                                        release:
                                            widget.entitySaveMini.release!),
                                    style: TextStyle(
                                      fontSize: theme.sizeText,
                                      letterSpacing: theme.letterSpacingText,
                                      color: theme.subtitle,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                            GestureDetector(
                              onTap: () {
                                switch (widget.typeObject) {
                                  case TypeObject.ENTITY:
                                    ScopedModel.of<EntityModel>(
                                            widget.contextAncestor)
                                        .updateLikeReview(
                                      context: widget.contextAncestor,
                                      idReview: widget.entitySaveMini.id,
                                    );
                                    break;
                                  case TypeObject.SEASON:
                                    ScopedModel.of<SeasonModel>(
                                            widget.contextAncestor)
                                        .updateLikeReview(
                                      context: widget.contextAncestor,
                                      idReview: widget.entitySaveMini.id,
                                    );
                                    break;
                                  case TypeObject.EPISODE:
                                    ScopedModel.of<EpisodeModel>(
                                            widget.contextAncestor)
                                        .updateLikeReview(
                                      context: widget.contextAncestor,
                                      idReview: widget.entitySaveMini.id,
                                    );
                                    break;
                                  default:
                                }
                              },
                              child: Row(
                                children: [
                                  Text(
                                    widget.entitySaveMini.likeQuantity
                                            .toString() +
                                        " ",
                                    style: TextStyle(
                                      fontSize: theme.sizeText,
                                      letterSpacing: theme.letterSpacingText,
                                      color: widget.entitySaveMini.liked
                                          ? theme.emphasis
                                          : theme.subtitle,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Icon(
                                    Icons.thumb_up_alt_outlined,
                                    size: theme.sizeText,
                                    color: widget.entitySaveMini.liked
                                        ? theme.emphasis
                                        : theme.subtitle,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  widget.entitySaveMini.commentQuantity
                                          .toString() +
                                      " ",
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
                              size: theme.sizeTitle,
                              color: Colors.transparent,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        //and row comments and likes
                      ],
                    ),
                  ),
                ),

                //and name

                // const SizedBox(
                //   width: 4.0,
                // ),
                // IconButton(
                //   padding: EdgeInsets.zero,
                //   onPressed: () {
                //     if (widget.entitySaveMini.user!.id ==
                //         ScopedModel.of<ProfileModel>(context).userMini.id) {
                //     } else {}
                //   },
                //   icon: Icon(
                //     Icons.more_vert_sharp,
                //     size: 21,
                //     color: ScopedModel.of<ThemeModel>(context).subtitle,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
