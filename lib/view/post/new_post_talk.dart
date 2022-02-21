import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

class NewPostTalk extends StatefulWidget {
  const NewPostTalk({Key? key}) : super(key: key);

  @override
  _NewPostTalkState createState() => _NewPostTalkState();
}

class _NewPostTalkState extends State<NewPostTalk> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'New Talk',
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
