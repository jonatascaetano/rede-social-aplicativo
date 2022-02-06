import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:admob_flutter/admob_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
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
      return ScopedModelDescendant<ProfileModel>(
          builder: (context, child, profile) {
        return Scaffold(
          body: Stack(
            children: [
              profile.postsAreNull
                  ? Container()
                  : ListView(
                      shrinkWrap: true,
                      children: [
                        Divider(
                          height: 5.0,
                          thickness: 5.0,
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
                            itemCount: profile.allPosts.length,
                            itemBuilder: (context, index) {
                              if (index % 4 == 0 && index != 0) {
                                return Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: theme.shadow,
                                      ),
                                      child: getBanner(
                                          AdmobBannerSize.MEDIUM_RECTANGLE),
                                    ),
                                    Divider(
                                      height: 10.0,
                                      thickness: 10.0,
                                      color: theme.shadow,
                                    ),
                                    profile.returnPostWidget(
                                        post: profile.allPosts[index],
                                        screenComment: false,
                                        contextPage: context),
                                    // UpdatePostEntityWidget(
                                    //   postUpdateMini: profile.posts[index],
                                    //   screenComment: false,
                                    // ),
                                  ],
                                );
                              } else {
                                return profile.returnPostWidget(
                                  post: profile.allPosts[index],
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
