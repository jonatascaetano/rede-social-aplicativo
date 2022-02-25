import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/converts/convert_date.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/objects/user.dart';

// ignore: must_be_immutable
class Reviews extends StatefulWidget {
  EntitySaveMini entitySaveMini;
  Reviews({required this.entitySaveMini, Key? key}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(
            height: 8.0,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 8.0,
              ),

              //**/ first imageProfile

              widget.entitySaveMini.user!.imageProfile != null
                  ? GestureDetector(
                      onTap: () {
                        if (widget.entitySaveMini.user!.id !=
                            ScopedModel.of<ProfileModel>(context).userMini.id) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => User(
                                    userMini: widget.entitySaveMini.user!)),
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
                            ScopedModel.of<ProfileModel>(context).userMini.id) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => User(
                                    userMini: widget.entitySaveMini.user!)),
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
              Expanded(
                  child: Wrap(
                children: [
                  Text(
                    widget.entitySaveMini.user!.name,
                    style: TextStyle(
                      fontSize: theme.sizeText,
                      letterSpacing: theme.letterSpacingText,
                      color: theme.title,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  widget.entitySaveMini.release == null
                      ? Container()
                      : Text(
                          " • " +
                              ConvertDate.convertToDatePost(
                                  release: widget.entitySaveMini.release!),
                          style: TextStyle(
                            fontSize: theme.sizeText,
                            letterSpacing: theme.letterSpacingText,
                            color: theme.title,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                ],
              )),

              //and name

              const SizedBox(
                width: 4.0,
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  if (widget.entitySaveMini.user!.id ==
                      ScopedModel.of<ProfileModel>(context).userMini.id) {
                  } else {}
                },
                icon: Icon(
                  Icons.more_vert_sharp,
                  size: 21,
                  color: ScopedModel.of<ThemeModel>(context).subtitle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          !widget.entitySaveMini.rated
              ? Container()
              : Container(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.star,
                          size: 40,
                          color: widget.entitySaveMini.evaluation! >= 1
                              ? Colors.yellow[700]
                              : theme.icon,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.star,
                          size: 40,
                          color: widget.entitySaveMini.evaluation! >= 2
                              ? Colors.yellow[700]
                              : theme.icon,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.star,
                          size: 40,
                          color: widget.entitySaveMini.evaluation! >= 3
                              ? Colors.yellow[700]
                              : theme.icon,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.star,
                          size: 40,
                          color: widget.entitySaveMini.evaluation! >= 4
                              ? Colors.yellow[700]
                              : theme.icon,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.star,
                          size: 40,
                          color: widget.entitySaveMini.evaluation! >= 5
                              ? Colors.yellow[700]
                              : theme.icon,
                        ),
                      ),
                    ],
                  ),
                ),
          !widget.entitySaveMini.spoiler
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 8.0),
                    child: Text(
                      widget.entitySaveMini.review!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: theme.sizeTitle,
                        letterSpacing: theme.letterSpacingText,
                        color: theme.title,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                )
              : ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 8.0),
                  title: Text(
                    'Spoiler',
                    style: TextStyle(
                      fontSize: theme.sizeTitle,
                      letterSpacing: theme.letterSpacingText,
                      color: theme.title,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 2, 8, 16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.entitySaveMini.review!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: theme.sizeTitle,
                            letterSpacing: theme.letterSpacingText,
                            color: theme.title,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          const SizedBox(
            height: 8.0,
          ),

          //first row comments and likes

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    // if (!widget.screenComment && !widget.screenUser) {
                    //   ScopedModel.of<ProfileModel>(context).updateLikePost(
                    //       context: context, idPost: widget.postUpdateMini.id!);
                    // } else if (widget.screenUser && !widget.screenComment) {
                    //   ScopedModel.of<UserModel>(widget.contextPage)
                    //       .updateLikePost(
                    //           context: widget.contextPage,
                    //           idPost: widget.postUpdateMini.id!);
                    // }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.button,
                      border: Border.all(
                        color: theme.button,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.thumb_up_alt_outlined,
                              size: theme.sizeTitle,
                              // color: widget.postUpdateMini.liked
                              //     ? theme.emphasis
                              //     : theme.title,
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              '37',
                              //widget.postUpdateMini.likeQuantity.toString(),
                              style: TextStyle(
                                fontSize: theme.sizeTitle,
                                letterSpacing: theme.letterSpacingText,
                                // color: widget.entitySaveMini.liked
                                //     ? theme.emphasis
                                //     : theme.title,
                                fontWeight: FontWeight.normal,
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
                  onTap: () {
                    // if (!widget.screenComment) {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => CommentsPostUpdate(
                    //         postUpdateMini: widget.postUpdateMini,
                    //         screenUser: widget.screenUser,
                    //         contextPage: widget.contextPage,
                    //       ),
                    //     ),
                    //   );
                    // }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.button,
                      border: Border.all(
                        color: theme.button,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.messenger_outline,
                              size: theme.sizeTitle,
                            ),
                            const SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              '123',
                              style: TextStyle(
                                fontSize: theme.sizeTitle,
                                letterSpacing: theme.letterSpacingText,
                                color: theme.title,
                                fontWeight: FontWeight.normal,
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
            height: 8.0,
          ),
          //and row comments and likes
        ],
      );
    });
  }
}
