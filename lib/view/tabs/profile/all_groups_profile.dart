import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/mini_profile/group_mini_profile.dart';

class AllGroupsProfile extends StatefulWidget {
  const AllGroupsProfile({Key? key}) : super(key: key);

  @override
  _AllGroupsProfileState createState() => _AllGroupsProfileState();
}

class _AllGroupsProfileState extends State<AllGroupsProfile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<ProfileModel>(builder: (context, child, profile) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              profile.userMini.name + " groups",
              style: TextStyle(
                color: theme.title,
                fontSize: 24.0,
                letterSpacing: 1.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          body: GridView.count(
            childAspectRatio: 1.0 / 1.7,
            crossAxisCount: 2,
            children: profile.groups.map((e) {
              return GroupMiniProfile(group: e);
            }).toList(),
          ),
        );
      });
    });
  }
}
