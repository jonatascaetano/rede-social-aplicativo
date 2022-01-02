import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/auxiliar/language_model.dart';
import 'package:social_network_application/view/abas/profile.dart';
import 'package:social_network_application/view/menu.dart';
import 'package:social_network_application/view/search/seach.dart';
import 'abas/home.dart';
import 'abas/trending.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<LanguageModel>(
        builder: (context, child, language) {
      List<Widget> select = [
        const Home(),
        const Trending(),
        const Profile(),
      ];
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text(
            "Application",
            style: TextStyle(color: Colors.purple),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
            ),
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search());
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Menu()));
                },
                icon: const Icon(Icons.dehaze_rounded))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: select[value],
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            currentIndex: value,
            onTap: (index) {
              setState(() {
                value = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                label: "home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "trending",
                icon: Icon(Icons.whatshot),
              ),
              BottomNavigationBarItem(
                label: "profile",
                icon: Icon(Icons.person_rounded),
              ),
            ]),
      );
    });
  }
}
