import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/menu.dart';
import 'package:social_network_application/view/search/seach.dart';

import 'tabs/home.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<LanguageModel>(
          builder: (context, child, language) {
        List<Widget> select = [
          const Home(),
          // const Trending(),
          // const Calendar(),
          //const Profile(),
        ];
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              "Bundle",
              style: TextStyle(
                color: theme.title,
                fontSize: 24,
                letterSpacing: theme.letterSpacingAppBar,
                fontWeight: FontWeight.normal,
              ),
            ),
            actions: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Container(
                  decoration: const BoxDecoration(
                      //color: theme.shadow,
                      //shape: BoxShape.circle,
                      ),
                  height: 50.0,
                  width: 50.0,
                  child: Icon(
                    Icons.notifications,
                    color: theme.title,
                    size: 28.0,
                  ),
                ),
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    ScopedModel.of<ProfileModel>(context)
                        .showOptionsAddPostBottomSheet(
                            contextAncestor: context);
                  },
                  icon: Container(
                    decoration: const BoxDecoration(
                        //color: theme.shadow,
                        //shape: BoxShape.circle,
                        ),
                    height: 50.0,
                    width: 50.0,
                    child: Icon(
                      Icons.add_circle_outline,
                      color: theme.title,
                      size: 28.0,
                    ),
                  )),
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    showSearch(context: context, delegate: Search());
                  },
                  icon: Container(
                    decoration: const BoxDecoration(
                        //color: theme.shadow,
                        //shape: BoxShape.circle,
                        ),
                    height: 50.0,
                    width: 50.0,
                    child: Icon(
                      Icons.search,
                      color: theme.title,
                      size: 28.0,
                    ),
                  )),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Menu()));
                },
                icon: Container(
                  decoration: const BoxDecoration(
                      // color: theme.shadow,
                      // shape: BoxShape.circle,
                      ),
                  height: 50.0,
                  width: 50.0,
                  child: Icon(
                    Icons.dehaze_rounded,
                    color: theme.title,
                    size: 28.0,
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: select[value],
          ),

          /*
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: theme.background,
              unselectedItemColor: theme.icon,
              selectedItemColor: theme.title,
              unselectedLabelStyle: TextStyle(color: theme.icon),
              showUnselectedLabels: true,
              elevation: 0.0,
              type: BottomNavigationBarType.fixed,
              currentIndex: value,
              onTap: (index) {
                setState(() {
                  value = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  label: "home",
                  icon: Icon(
                    Icons.home,
                    //size: 30.0,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "trending",
                  icon: Icon(
                    Icons.whatshot,
                    //size: 30.0,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "calendar",
                  icon: Icon(
                    Icons.calendar_today,
                    //size: 30.0,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "profile",
                  icon: Icon(
                    Icons.person_rounded,
                    //size: 30.0,
                  ),
                ),
              ]),
              */
        );
      });
    });
  }
}
