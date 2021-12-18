import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/database_model.dart';
import 'package:social_network_application/scoped_model/language_model.dart';
import 'package:social_network_application/view/seach.dart';
import 'home.dart';
import 'profile.dart';
import 'trending.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<DatabaseModel>(
        builder: (context, child, database) {
      return ScopedModelDescendant<LanguageModel>(
          builder: (context, child, language) {
        List<Widget> select = [
          const Home(),
          const Trending(),
          Profile(
            id: database.id,
            isUser: true,
          ),
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
              PopupMenuButton<String>(
                  //icon: const Icon(Icons.dehaze),
                  onSelected: (item) {
                database.popupMenuButtonSelect(item: item, context: context);
              }, itemBuilder: (context) {
                return language.popupMenuButtonList.map((item) {
                  return PopupMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList();
              })
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
                BottomNavigationBarItem(label: "home", icon: Icon(Icons.home)),
                BottomNavigationBarItem(
                    label: "trending", icon: Icon(Icons.whatshot)),
                BottomNavigationBarItem(
                    label: "profile", icon: Icon(Icons.person_rounded)),
              ]),
        );
      });
    });
  }
}
