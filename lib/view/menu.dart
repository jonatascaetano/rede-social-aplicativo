import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/auxiliar/language_model.dart';
import 'package:social_network_application/scoped_model/auxiliar/menu_model.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MenuModel>(
        model: MenuModel(context: context),
        child:
            ScopedModelDescendant<MenuModel>(builder: (context, child, menu) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: const Text(
                'Menu',
                style: TextStyle(color: Colors.purple),
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
                              const Icon(
                                Icons.drafts,
                                size: 18,
                                color: Colors.purple,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Expanded(
                                child: Text(
                                  "Invitation",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Text(
                                menu.invitation,
                                style: const TextStyle(fontSize: 18),
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
                              const Icon(
                                Icons.language,
                                size: 18,
                                color: Colors.purple,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Expanded(
                                child: Text(
                                  "Language",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Text(
                                LanguageModel().language,
                                style: const TextStyle(fontSize: 18),
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
                            const Icon(
                              Icons.dark_mode,
                              size: 18,
                              color: Colors.purple,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Expanded(
                              child: Text(
                                "Dark mode",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Switch.adaptive(
                                value: menu.isDark,
                                onChanged: (value) {
                                  menu.saveDarkMode(darkMode: value);
                                })
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.logout,
                                size: 18,
                                color: Colors.purple,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Exit",
                                style: TextStyle(fontSize: 18),
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
  }
}
