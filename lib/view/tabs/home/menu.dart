import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/menu_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/tabs/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<MenuModel>(
          model: MenuModel(context: context),
          child:
              ScopedModelDescendant<MenuModel>(builder: (context, child, menu) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: Text(
                  'Menu',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView(
                      //shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            child: Column(
                              children: [
                                Divider(
                                  color: theme.button,
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      !ScopedModel.of<ProfileModel>(context)
                                              .profileNull
                                          ? ScopedModel.of<ProfileModel>(
                                                          context)
                                                      .userMini
                                                      .imageProfile !=
                                                  null
                                              ? CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      ScopedModel.of<
                                                                  ProfileModel>(
                                                              context)
                                                          .userMini
                                                          .imageProfile!),
                                                  radius: 30.0,
                                                )
                                              : CircleAvatar(
                                                  backgroundColor: theme.shadow,
                                                  child: Icon(
                                                    Icons.image,
                                                    color: theme.emphasis,
                                                  ),
                                                  radius: 30.0,
                                                )
                                          : Container(),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                120,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            !ScopedModel.of<ProfileModel>(
                                                        context)
                                                    .profileNull
                                                ? Text(
                                                    // ignore: unnecessary_null_comparison
                                                    ScopedModel.of<
                                                                ProfileModel>(
                                                            context)
                                                        .userMini
                                                        .name,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: theme.sizeTitle,
                                                      letterSpacing: theme
                                                          .letterSpacingTitle,
                                                      color: theme.title,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  )
                                                : Text(
                                                    'Profile',
                                                    style: TextStyle(
                                                      fontSize: theme.sizeTitle,
                                                      letterSpacing: theme
                                                          .letterSpacingTitle,
                                                      color: theme.title,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                            const SizedBox(
                                              height: 2.0,
                                            ),
                                            Text(
                                              "View your profile",
                                              style: TextStyle(
                                                fontSize: theme.sizeText,
                                                letterSpacing:
                                                    theme.letterSpacingText,
                                                color: theme.subtitle,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Divider(
                                  color: theme.button,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Profile(),
                              ),
                            );
                          },
                        ),

                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.drafts,
                                  size: 24,
                                  color: theme.emphasis,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Text(
                                    "Invitation",
                                    style: TextStyle(
                                      fontSize: theme.sizeText,
                                      letterSpacing: theme.letterSpacingText,
                                      color: theme.title,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Text(
                                  menu.invitation,
                                  style: TextStyle(
                                    fontSize: theme.sizeText,
                                    letterSpacing: theme.letterSpacingText,
                                    color: theme.title,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                        // GestureDetector(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(12.0),
                        //     child: Row(
                        //       children: const [
                        //         Icon(
                        //           Icons.groups,
                        //           size: 18,
                        //           color: Colors.purple,
                        //         ),
                        //         SizedBox(
                        //           width: 8,
                        //         ),
                        //         Text(
                        //           "Groups",
                        //           style: TextStyle(fontSize: 18),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        //   onTap: () {},
                        // ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.language,
                                  size: 24,
                                  color: theme.emphasis,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Text(
                                    "Language",
                                    style: TextStyle(
                                      fontSize: theme.sizeText,
                                      letterSpacing: theme.letterSpacingText,
                                      color: theme.title,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Text(
                                  LanguageModel().language,
                                  style: TextStyle(
                                    fontSize: theme.sizeText,
                                    letterSpacing: theme.letterSpacingText,
                                    color: theme.title,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.dark_mode,
                                size: 24,
                                color: theme.emphasis,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  "Dark mode",
                                  style: TextStyle(
                                    fontSize: theme.sizeText,
                                    letterSpacing: theme.letterSpacingText,
                                    color: theme.title,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Switch.adaptive(
                                    value: menu.isDark,
                                    onChanged: (value) {
                                      menu.saveDarkMode(
                                          dark: value, context: context);
                                    }),
                              )
                            ],
                          ),
                        ),
                        // GestureDetector(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(12.0),
                        //     child: Row(
                        //       children: [
                        //         Icon(
                        //           Icons.add_circle,
                        //           size: 24,
                        //           color: theme.emphasis,
                        //         ),
                        //         const SizedBox(
                        //           width: 8,
                        //         ),
                        //         Text(
                        //           "New register",
                        //           style: TextStyle(
                        //             fontSize: theme.sizeText,
                        //             letterSpacing: theme.letterSpacingText,
                        //             color: theme.title,
                        //             fontWeight: FontWeight.normal,
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        //   onTap: () {
                        //     menu.showListEntitiesBottomSheet(context);

                        //     // if (ScopedModel.of<ProfileModel>(context)
                        //     //     .userMini
                        //     //     .checked) {
                        //     //   menu.showListEntitiesBottomSheet(context);
                        //     // } else {
                        //     //   ScaffoldMessenger.of(context).showSnackBar(
                        //     //     const SnackBar(
                        //     //         content: Text(
                        //     //             'only released to verified users')),
                        //     //   );
                        //     // }
                        //   },
                        // ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: 24,
                                  color: theme.emphasis,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Exit",
                                  style: TextStyle(
                                    fontSize: theme.sizeText,
                                    letterSpacing: theme.letterSpacingText,
                                    color: theme.title,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            menu.logOut(context: context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 8.0,
                      left: 20.0,
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'terms of use ',
                            style: TextStyle(
                              fontSize:
                                  ScopedModel.of<ThemeModel>(context).sizeText,
                              color:
                                  ScopedModel.of<ThemeModel>(context).emphasis,
                              letterSpacing: ScopedModel.of<ThemeModel>(context)
                                  .letterSpacingText,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                const url =
                                    'https://euteconto-app.blogspot.com/2020/12/termos-de-uso_29.html';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        TextSpan(
                          text: 'and ',
                          style: TextStyle(
                            fontSize:
                                ScopedModel.of<ThemeModel>(context).sizeText,
                            color: ScopedModel.of<ThemeModel>(context).title,
                            letterSpacing: ScopedModel.of<ThemeModel>(context)
                                .letterSpacingText,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                            text: 'privacy policy ',
                            style: TextStyle(
                              fontSize:
                                  ScopedModel.of<ThemeModel>(context).sizeText,
                              color:
                                  ScopedModel.of<ThemeModel>(context).emphasis,
                              letterSpacing: ScopedModel.of<ThemeModel>(context)
                                  .letterSpacingText,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                const url =
                                    'https://euteconto-app.blogspot.com/2021/01/politica-de-privacidade.html';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              })
                      ]))),
                  menu.load
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
