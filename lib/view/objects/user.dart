import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/helper/return_widget_post.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/scoped_model/user_model.dart';
import 'package:social_network_application/view/tabs/profile/followers.dart';
import 'package:social_network_application/view/tabs/profile/following.dart';
import 'package:social_network_application/widgets/mini_profile/entities_mini_profile.dart';
import 'package:social_network_application/widgets/mini_profile/entity_mini_profile_evaluated.dart';

// ignore: must_be_immutable
class User extends StatefulWidget {
  UserMini userMini;
  User({required this.userMini, Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
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
      return ScopedModel<UserModel>(
        model: UserModel(idUser: widget.userMini.id, context: context),
        child: ScopedModelDescendant<UserModel>(builder: (context, child, user) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: !user.profileNull
                  ? Text(
                      user.userMini.name,
                      style: TextStyle(
                        color: theme.title,
                        fontSize: theme.sizeAppBar,
                        letterSpacing: theme.letterSpacingAppBar,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  : const Text(''),
            ),
            body: Container(
              //margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              padding: EdgeInsets.zero,
              child: Stack(
                children: [
                  user.profileNull || user.goalsIsNull
                      ? Container()
                      : ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            //inicio da area profile
                            user.userMini.imageProfile != null
                                ? Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.zero,
                                        height: (MediaQuery.of(context).size.width / 16) * 9,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: theme.shadow,
                                          image: DecorationImage(
                                            image: NetworkImage(user.userMini.imageProfile!),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                      user.profileNull
                                          ? Container()
                                          : Positioned(
                                              top: 8.0,
                                              right: 8.0,
                                              child: IconButton(
                                                onPressed: () {
                                                  user.showOptionsUserBottomSheet(
                                                    contextPageUser: context,
                                                    idUser: widget.userMini.id,
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.more_vert_sharp,
                                                  size: 21,
                                                  color: ScopedModel.of<ThemeModel>(context).subtitle,
                                                ),
                                              ),
                                            ),
                                    ],
                                  )
                                : Stack(
                                    children: [
                                      Container(
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
                                      user.profileNull
                                          ? Container()
                                          : Positioned(
                                              top: 8.0,
                                              right: 8.0,
                                              child: IconButton(
                                                onPressed: () {
                                                  user.showOptionsUserBottomSheet(
                                                    contextPageUser: context,
                                                    idUser: widget.userMini.id,
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.more_vert_sharp,
                                                  size: 21,
                                                  color: ScopedModel.of<ThemeModel>(context).subtitle,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            // user.userMini.image != null
                            //     ? Padding(
                            //         padding:
                            //             const EdgeInsets.fromLTRB(0, 100, 0, 8),
                            //         child: CircleAvatar(
                            //           backgroundImage: NetworkImage(
                            //               user.userMini.image.toString()),
                            //           radius: 60.0,
                            //         ),
                            //       )
                            //     : Padding(
                            //         padding:
                            //             const EdgeInsets.fromLTRB(0, 100, 0, 8),
                            //         child: CircleAvatar(
                            //           backgroundColor: Colors.grey[300],
                            //           child: const Icon(
                            //             Icons.person,
                            //             size: 80.0,
                            //           ),
                            //           radius: 60.0,
                            //         ),
                            //       ),
                            // const SizedBox(
                            //   height: 16.0,
                            // ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            user.userMini.name,
                                            style: TextStyle(
                                              fontSize: theme.sizeTitle,
                                              letterSpacing: theme.letterSpacingTitle,
                                              color: theme.title,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 2.0,
                                          ),
                                          user.userMini.checked
                                              ? Icon(
                                                  Icons.check_circle_outlined,
                                                  color: theme.emphasis,
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            user.userMini.description != null && user.userMini.description!.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      user.userMini.description!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: theme.sizeText,
                                        letterSpacing: theme.letterSpacingText,
                                        color: theme.subtitle,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  )
                                : Container(),

                            user.blocked
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.block,
                                          color: theme.detail,
                                        ),
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        Text(
                                          'User blocked',
                                          style: TextStyle(
                                            fontSize: theme.sizeText,
                                            letterSpacing: theme.letterSpacingText,
                                            color: theme.detail,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: user.showFollowButton
                                        ? user.isFollowing
                                            ? ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: theme.button,
                                                  elevation: 0.0,
                                                ),
                                                onPressed: () {
                                                  user.removeFollowing(
                                                    idFollowing: user.userMini.id,
                                                    context: context,
                                                  );
                                                },
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.person_remove,
                                                      color: theme.detail,
                                                    ),
                                                    const SizedBox(
                                                      width: 4.0,
                                                    ),
                                                    Text(
                                                      'Unfollow',
                                                      style: TextStyle(
                                                        fontSize: theme.sizeButton,
                                                        letterSpacing: theme.letterSpacingButton,
                                                        color: theme.buttonText,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: theme.button,
                                                  elevation: 0.0,
                                                ),
                                                onPressed: () {
                                                  user.addFollowing(
                                                    idFollowing: user.userMini.id,
                                                    context: context,
                                                  );
                                                },
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.person_add,
                                                      color: theme.emphasis,
                                                    ),
                                                    const SizedBox(
                                                      width: 4.0,
                                                    ),
                                                    Text(
                                                      'Follow',
                                                      style: TextStyle(
                                                        fontSize: theme.sizeButton,
                                                        letterSpacing: theme.letterSpacingButton,
                                                        color: theme.buttonText,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                        : Container(),
                                  ),

                            const SizedBox(
                              height: 8.0,
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Followers(
                                                        idUser: user.userMini.id,
                                                        isUser: false,
                                                      )));
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              'Followers',
                                              style: TextStyle(
                                                fontSize: theme.sizeText,
                                                letterSpacing: theme.letterSpacingText,
                                                color: theme.subtitle,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 4.0,
                                            ),
                                            Text(
                                              user.userMini.quantityFollowers.toString(),
                                              style: TextStyle(
                                                fontSize: theme.sizeText,
                                                letterSpacing: theme.letterSpacingText,
                                                color: theme.subtitle,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Following(
                                                          idUser: user.userMini.id,
                                                          isUser: false,
                                                        )));
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                'Following',
                                                style: TextStyle(
                                                  fontSize: theme.sizeText,
                                                  letterSpacing: theme.letterSpacingText,
                                                  color: theme.subtitle,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 4.0,
                                              ),
                                              Text(
                                                user.userMini.quantityFollowing.toString(),
                                                style: TextStyle(
                                                  fontSize: theme.sizeText,
                                                  letterSpacing: theme.letterSpacingText,
                                                  color: theme.subtitle,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // user.userMini.place != null
                            //     ? Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Row(
                            //           children: [
                            //             Icon(
                            //               Icons.place,
                            //               color: theme.detail,
                            //             ),
                            //             const SizedBox(
                            //               width: 4.0,
                            //             ),
                            //             Text(
                            //               user.userMini.place!,
                            //               style: TextStyle(
                            //                 fontSize: 18,
                            //                 letterSpacing: 0.5,
                            //                 color: theme.title,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       )
                            //     : Container(),

                            user.goals.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'View all goals',
                                            style: TextStyle(
                                              fontSize: theme.sizeTitle,
                                              letterSpacing: theme.letterSpacingTitle,
                                              color: theme.emphasis,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => AllWorkersProfile(
                                            //       isUser: true,
                                            //       userMini: profile.userMini,
                                            //       workers: profile.workers,
                                            //     ),
                                            //   ),
                                            // );
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward,
                                            color: theme.subtitle,
                                            size: 24.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),

                            user.goals.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: SizedBox(
                                      height: 280,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: user.goals.length,
                                          itemBuilder: (context, index) {
                                            return EntityMiniProfileEvaluated(entitySaveMini: user.goals[index]);
                                          }),
                                    ),
                                  )
                                : Container(),

                            Divider(
                              height: 10.0,
                              thickness: 10.0,
                              color: theme.shadow,
                            ),

                            /*    

                            user.workers.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'View all works',
                                            style: TextStyle(
                                              fontSize: theme.sizeText,
                                              letterSpacing: theme.letterSpacingText,
                                              color: theme.subtitle,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => AllWorkersUser(
                                                  isUser: false,
                                                  userMini: user.userMini,
                                                  workers: user.workers,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward,
                                            color: theme.subtitle,
                                            size: 24.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),

                            user.workers.isNotEmpty
                                ? SizedBox(
                                    height: 260,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: user.workers.length,
                                        itemBuilder: (context, index) {
                                          return WorkerMiniProfile(
                                            workerMini: user.workers[index],
                                            isUser: false,
                                          );
                                        }),
                                  )
                                : Container(),

                            const SizedBox(
                              height: 16.0,
                            ),

                            */

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: LanguageModel()
                                      .typeEntitiesMini
                                      .map(
                                        (e) => EntityMiniProfile(
                                          index: LanguageModel().typeEntitiesMini.indexOf(e),
                                          isUser: false,
                                          idUser: widget.userMini.id,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                            //final da area profile

                            //inicio area post
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
                                itemCount: user.myPosts.length,
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
                                          post: user.myPosts[index],
                                          screenComment: false,
                                          contextPage: context,
                                          screenGroup: false,
                                          screenUser: true,
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
                                      post: user.myPosts[index],
                                      screenComment: false,
                                      contextPage: context,
                                      screenGroup: false,
                                      screenUser: true,
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
                  user.load
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
