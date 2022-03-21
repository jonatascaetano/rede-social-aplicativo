import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/tabs/profile/update_profile.dart';
import 'package:social_network_application/widgets/mini_profile/entities_mini_profile.dart';
import 'package:social_network_application/widgets/mini_profile/entity_mini_profile_evaluated.dart';
import 'profile/followers.dart';
import 'profile/following.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      return ScopedModelDescendant<ProfileModel>(builder: (context, child, profile) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              'Profile',
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
              profile.profileNull
                  ? Container()
                  : ListView(
                      shrinkWrap: true,
                      children: [
                        profile.userMini.imageProfile != null
                            ? Container(
                                height: (MediaQuery.of(context).size.width / 16) * 9,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: theme.shadow,
                                  image: DecorationImage(
                                    image: NetworkImage(profile.userMini.imageProfile!),
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

                        const SizedBox(
                          height: 16.0,
                        ),
                        // profile.userMini.image != null
                        //     ? Padding(
                        //         padding:
                        //             const EdgeInsets.fromLTRB(0, 60, 0, 0),
                        //         child: CircleAvatar(
                        //           backgroundImage: NetworkImage(
                        //               profile.userMini.image.toString()),
                        //           radius: 60.0,
                        //         ),
                        //       )
                        //     : Padding(
                        //         padding:
                        //             const EdgeInsets.fromLTRB(0, 60, 0, 0),
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
                                        profile.userMini.name,
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
                                      profile.userMini.checked
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
                        profile.userMini.description != null && profile.userMini.description!.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  profile.userMini.description!,
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

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: theme.button,
                              elevation: 0.0,
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateProfile()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: theme.buttonMain,
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  'edit profile',
                                  style: TextStyle(
                                    fontSize: theme.sizeButton,
                                    letterSpacing: theme.letterSpacingButton,
                                    color: theme.buttonText,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                                    idUser: profile.userMini.id,
                                                    isUser: true,
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
                                          profile.userMini.quantityFollowers.toString(),
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
                                    width: 4.0,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Following(
                                                      idUser: profile.userMini.id,
                                                      isUser: true,
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
                                            profile.userMini.quantityFollowing.toString(),
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
                        // profile.userMini.place != null
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
                        //               profile.userMini.place!,
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

                        profile.goals.isNotEmpty
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

                        profile.goals.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: SizedBox(
                                  height: 280,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: profile.goals.length,
                                      itemBuilder: (context, index) {
                                        return EntityMiniProfileEvaluated(entitySaveMini: profile.goals[index]);
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

                        profile.workers.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'View all works',
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AllWorkersProfile(
                                              isUser: true,
                                              userMini: profile.userMini,
                                              workers: profile.workers,
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

                        // profile.workers.isNotEmpty
                        //     ? Row(
                        //         children: [
                        //           const Text(
                        //             'Workers',
                        //             style: TextStyle(
                        //               fontSize: 18,
                        //               letterSpacing: 2.0,
                        //             ),
                        //           ),
                        //           const SizedBox(
                        //             width: 24.0,
                        //           ),
                        //           IconButton(
                        //               onPressed: () {},
                        //               icon: const Icon(Icons.arrow_forward)),
                        //         ],
                        //       )
                        //     : Container(),
                        profile.workers.isNotEmpty
                            ? SizedBox(
                                height: 260,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: profile.workers.length,
                                    itemBuilder: (context, index) {
                                      return WorkerMiniProfile(
                                        workerMini: profile.workers[index],
                                        isUser: true,
                                      );
                                    }),
                              )
                            : Container(),

                        profile.workers.isNotEmpty
                            ? const SizedBox(
                                height: 24.0,
                              )
                            : Container(),

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
                                      isUser: true,
                                      idUser: profile.userMini.id,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),

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
                            itemCount: profile.myPosts.length,
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
                                    profile.returnPostWidget(post: profile.myPosts[index], screenComment: false, contextPage: context),
                                    // UpdatePostEntityWidget(
                                    //   postUpdateMini: profile.posts[index],
                                    //   screenComment: false,
                                    // ),
                                  ],
                                );
                              } else {
                                return profile.returnPostWidget(
                                  post: profile.myPosts[index],
                                  screenComment: false,
                                  contextPage: context,
                                );
                                // UpdatePostEntityWidget(
                                //   postUpdateMini: profile.posts[index],
                                //   screenComment: false,
                                // );
                              }
                            }),
                      ],
                    ),
              profile.load
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
    });
  }
}
