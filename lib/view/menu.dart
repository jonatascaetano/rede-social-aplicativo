import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/menu_model.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

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
                    fontSize: 24.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
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
                                        fontSize: 19, color: theme.title),
                                  ),
                                ),
                                Text(
                                  menu.invitation,
                                  style: TextStyle(
                                      fontSize: 19, color: theme.title),
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
                            padding: const EdgeInsets.all(16.0),
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
                                        fontSize: 19, color: theme.title),
                                  ),
                                ),
                                Text(
                                  LanguageModel().language,
                                  style: TextStyle(
                                      fontSize: 19, color: theme.title),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                                      fontSize: 19, color: theme.title),
                                ),
                              ),
                              Switch.adaptive(
                                  value: menu.isDark,
                                  onChanged: (value) {
                                    menu.saveDarkMode(
                                        dark: value, context: context);
                                  })
                            ],
                          ),
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add_circle,
                                  size: 24,
                                  color: theme.emphasis,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text("Register new",
                                    style: TextStyle(
                                        fontSize: 19, color: theme.title)),
                              ],
                            ),
                          ),
                          onTap: () {
                            menu.showListEntitiesBottomSheet(context);
                          },
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
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
                                      fontSize: 19, color: theme.title),
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
