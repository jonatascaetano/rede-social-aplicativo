import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/helper/return_widget_post.dart';
import 'package:social_network_application/scoped_model/group_mode.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/added_post.dart';

// ignore: must_be_immutable
class Group extends StatefulWidget {
  String idGroup;
  Group({required this.idGroup, Key? key}) : super(key: key);

  @override
  State<Group> createState() => _GroupState();
}

class _GroupState extends State<Group> {
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
        handleEvent(event, args!, 'Banner');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel(
        model: GroupModel(idGroup: widget.idGroup, contextPageGroup: context),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  group.groupMini.quantityMembers.toString() + ' members ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: theme.sizeText,
                                    letterSpacing: theme.letterSpacingText,
                                    color: theme.detail,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                // const SizedBox(
                                //   width: 8.0,
                                // ),
                                // Icon(
                                //   Icons.groups_rounded,
                                //   color: theme.detail,
                                // )
                              ],
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

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       'Posts ' + group.groupMini.quantityPosts.toString(),
                            //       textAlign: TextAlign.center,
                            //       style: TextStyle(
                            //         fontSize: theme.sizeText,
                            //         letterSpacing: theme.letterSpacingText,
                            //         color: theme.subtitle,
                            //         fontWeight: FontWeight.normal,
                            //       ),
                            //     ),
                            //     const SizedBox(
                            //       width: 8.0,
                            //     ),
                            //     Icon(
                            //       Icons.assistant_photo_sharp,
                            //       color: theme.detail,
                            //     )
                            //   ],
                            // ),
                            // const SizedBox(
                            //   height: 8.0,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //   child: Text(
                            //     'Created by ' + group.groupMini.creator!.name,
                            //     style: TextStyle(
                            //       fontSize: theme.sizeText,
                            //       letterSpacing: theme.letterSpacingText,
                            //       color: theme.subtitle,
                            //       fontWeight: FontWeight.normal,
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 4.0,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            //   child: Text(
                            //     'Created in ' + group.groupMini.creationDate,
                            //     style: TextStyle(
                            //       fontSize: theme.sizeText,
                            //       letterSpacing: theme.letterSpacingText,
                            //       color: theme.subtitle,
                            //       fontWeight: FontWeight.normal,
                            //     ),
                            //   ),
                            // ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: group.groupMini.userIsMember ? Colors.red : theme.buttonMain,
                                    elevation: 0.0,
                                    //fixedSize: const Size(30, 30),
                                    //shape: const CircleBorder(),
                                  ),
                                  onPressed: () {
                                    // season.showOptionsSeasonBottomSheet(
                                    //   contextAncestor: context,
                                    //   seasonMini: season.seasonMini,
                                    // );
                                  },
                                  child: group.groupMini.userIsMember
                                      ? Text(
                                          "Exit",
                                          style: TextStyle(
                                            fontSize: theme.sizeButton,
                                            letterSpacing: theme.letterSpacingButton,
                                            color: theme.buttonMainText,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                      : Text(
                                          "Enter",
                                          style: TextStyle(
                                            fontSize: theme.sizeButton,
                                            letterSpacing: theme.letterSpacingButton,
                                            color: theme.buttonMainText,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 16.0,
                            ),

                            Divider(
                              height: 10.0,
                              thickness: 10.0,
                              color: theme.shadow,
                            ),

                            AddedPost(
                              user: false,
                              idGroup: group.groupMini.id,
                              contextScreenGroup: context,
                            ),

                            // group.groupMini.quantityPosts == 0
                            //     ? Container()
                            //     :
                            Divider(
                              height: 10.0,
                              thickness: 10.0,
                              color: theme.shadow,
                            ),

                            ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    height: 10.0,
                                    thickness: 10.0,
                                    color: theme.shadow,
                                  );
                                },
                                itemCount: group.posts.length,
                                itemBuilder: (context, index) {
                                  if (index % 8 == 0 && index != 0) {
                                    return Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: theme.shadow,
                                          ),
                                          child: getBanner(AdmobBannerSize.MEDIUM_RECTANGLE),
                                        ),
                                        Divider(
                                          height: 10.0,
                                          thickness: 10.0,
                                          color: theme.shadow,
                                        ),
                                        ReturnWidgetPost.returnPostWidget(
                                          post: group.posts[index],
                                          screenComment: false,
                                          contextPage: context,
                                          screenGroup: true,
                                          screenUser: false,
                                          screenProfile: false,
                                        ),
                                        // UpdatePostEntityWidget(
                                        //   postUpdateMini: profile.posts[index],
                                        //   screenComment: false,
                                        // ),
                                      ],
                                    );
                                  } else {
                                    return ReturnWidgetPost.returnPostWidget(
                                      post: group.posts[index],
                                      screenComment: false,
                                      contextPage: context,
                                      screenGroup: true,
                                      screenUser: false,
                                      screenProfile: false,
                                    );
                                    // UpdatePostEntityWidget(
                                    //   postUpdateMini: profile.posts[index],
                                    //   screenComment: false,
                                    // );
                                  }
                                }),
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
