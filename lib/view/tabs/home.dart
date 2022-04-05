import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/helper/return_widget_post.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:social_network_application/widgets/added_post.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        //handleEvent(event, args!, 'Banner');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<ProfileModel>(builder: (context, child, profile) {
        return Scaffold(
          body: Stack(
            children: [
              profile.postsAreNull
                  ? Container()
                  : profile.allPosts.isEmpty
                      ? Center(
                          child: Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: theme.shadow,
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Posts',
                                    style: TextStyle(
                                      color: theme.title,
                                      fontSize: theme.sizeAppBar,
                                      letterSpacing: theme.letterSpacingAppBar,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              )),
                        )
                      : ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: [
                            Divider(
                              height: 10.0,
                              thickness: 10.0,
                              color: theme.shadow,
                            ),
                            AddedPost(
                              user: true,
                              idGroup: null,
                            ),
                            Divider(
                              height: 10.0,
                              thickness: 10.0,
                              color: theme.shadow,
                            ),
                            ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    height: 10.0,
                                    thickness: 10.0,
                                    color: theme.shadow,
                                  );
                                },
                                itemCount: profile.allPosts.length,
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
                                          post: profile.allPosts[index],
                                          screenComment: false,
                                          contextPage: context,
                                          screenGroup: false,
                                          screenUser: false,
                                        ),
                                        // UpdatePostEntityWidget(
                                        //   postUpdateMini: profile.posts[index],
                                        //   screenComment: false,
                                        // ),
                                      ],
                                    );
                                  } else {
                                    return ReturnWidgetPost.returnPostWidget(
                                      post: profile.allPosts[index],
                                      screenComment: false,
                                      contextPage: context,
                                      screenGroup: false,
                                      screenUser: false,
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
                      bottom: 0.0,
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
