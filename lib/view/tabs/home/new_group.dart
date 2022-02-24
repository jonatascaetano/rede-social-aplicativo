import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({Key? key}) : super(key: key);

  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'New Group',
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
