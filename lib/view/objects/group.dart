import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/group_mini.dart';
import 'package:social_network_application/scoped_model/group_mode.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

// ignore: must_be_immutable
class Group extends StatefulWidget {
  GroupMini groupMini;
  Group({required this.groupMini, Key? key}) : super(key: key);

  @override
  State<Group> createState() => _GroupState();
}

class _GroupState extends State<Group> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel(
        model: GroupModel(idGroup: widget.groupMini.id, contextPageGroup: context),
        child: ScopedModelDescendant<GroupModel>(builder: (context, child, group) {
          return Scaffold(
            appBar: AppBar(
                elevation: 0.0,
                title: group.groupIsNull
                    ? Container()
                    : Text(
                        group.groupMini.name,
                        style: TextStyle(
                          color: theme.title,
                          fontSize: theme.sizeAppBar,
                          letterSpacing: theme.letterSpacingAppBar,
                          fontWeight: FontWeight.normal,
                        ),
                      )),
            body: SizedBox(
              child: Stack(
                children: [
                  group.groupIsNull
                      ? Container()
                      : ListView(
                          children: [
                            Stack(
                              children: [
                                group.groupMini.image != null
                                    ? Container(
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        height: (MediaQuery.of(context).size.width / 16) * 9,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: theme.shadow,
                                          image: DecorationImage(
                                            image: NetworkImage(group.groupMini.image!),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        color: theme.shadow,
                                        height: (MediaQuery.of(context).size.width / 16) * 9,
                                        width: MediaQuery.of(context).size.width,
                                        child: Center(
                                          child: Icon(
                                            Icons.image,
                                            size: 100,
                                            color: theme.emphasis,
                                          ),
                                        )),
                                group.groupIsNull
                                    ? Container()
                                    : Positioned(
                                        bottom: 8.0,
                                        right: 8.0,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: theme.buttonMain,
                                            elevation: 0.0,
                                            fixedSize: const Size(30, 30),
                                            shape: const CircleBorder(),
                                          ),
                                          onPressed: () {
                                            // season.showOptionsSeasonBottomSheet(
                                            //   contextAncestor: context,
                                            //   seasonMini: season.seasonMini,
                                            // );
                                          },
                                          child: Icon(
                                            Icons.add,
                                            size: 30,
                                            color: ScopedModel.of<ThemeModel>(context).buttonMainText,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              group.groupMini.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: theme.sizeTitle,
                                letterSpacing: theme.letterSpacingTitle,
                                color: theme.title,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                group.groupMini.description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: theme.sizeText,
                                  letterSpacing: theme.letterSpacingText,
                                  color: theme.subtitle,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Members ' + group.groupMini.quantityMembers.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: theme.sizeText,
                                    letterSpacing: theme.letterSpacingText,
                                    color: theme.subtitle,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Icon(
                                  Icons.groups_rounded,
                                  color: theme.detail,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Posts ' + group.groupMini.quantityPosts.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: theme.sizeText,
                                    letterSpacing: theme.letterSpacingText,
                                    color: theme.subtitle,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Icon(
                                  Icons.assistant_photo_sharp,
                                  color: theme.detail,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Created by ' + group.groupMini.creator!.name,
                                style: TextStyle(
                                  fontSize: theme.sizeText,
                                  letterSpacing: theme.letterSpacingText,
                                  color: theme.subtitle,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Created in ' + group.groupMini.creationDate,
                                style: TextStyle(
                                  fontSize: theme.sizeText,
                                  letterSpacing: theme.letterSpacingText,
                                  color: theme.subtitle,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            group.groupMini.quantityPosts == 0
                                ? Container()
                                : Divider(
                                    height: 5.0,
                                    thickness: 5.0,
                                    color: theme.shadow,
                                  ),
                          ],
                        ),
                  group.load
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
            ),
          );
        }),
      );
    });
  }
}
