import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

class NewPostQuest extends StatefulWidget {
  const NewPostQuest({Key? key}) : super(key: key);

  @override
  _NewPostQuestState createState() => _NewPostQuestState();
}

class _NewPostQuestState extends State<NewPostQuest> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'New Quest',
            style: TextStyle(
              color: theme.title,
              fontSize: theme.sizeAppBar,
              letterSpacing: theme.letterSpacingAppBar,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      );
    });
  }
}
