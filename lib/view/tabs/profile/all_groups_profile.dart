import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/group_mini.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/mini_profile/group_mini_profile.dart';

// ignore: must_be_immutable
class AllGroupsProfile extends StatefulWidget {
  List<GroupMini> groups;
  AllGroupsProfile({required this.groups, Key? key}) : super(key: key);

  @override
  _AllGroupsProfileState createState() => _AllGroupsProfileState();
}

class _AllGroupsProfileState extends State<AllGroupsProfile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Groups",
            style: TextStyle(
              color: theme.title,
              fontSize: theme.sizeAppBar,
              letterSpacing: 1.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            childAspectRatio: 1.0 / 1.0,
            crossAxisCount: 2,
            children: widget.groups.map((e) {
              return Align(alignment: Alignment.topCenter, child: GroupMiniProfile(group: e));
            }).toList(),
          ),
        ),
      );
    });
  }
}
