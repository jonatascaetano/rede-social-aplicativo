import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/mini_profile/entity_mini_profile_evaluated.dart';

class AllGoalsProfile extends StatefulWidget {
  const AllGoalsProfile({Key? key}) : super(key: key);

  @override
  _AllGoalsProfileState createState() => _AllGoalsProfileState();
}

class _AllGoalsProfileState extends State<AllGoalsProfile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<ProfileModel>(builder: (context, child, profile) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              profile.userMini.name + " goals",
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
            children: profile.goals.map((e) {
              return EntityMiniProfileEvaluated(entitySaveMini: e);
            }).toList(),
          ),
        );
      });
    });
  }
}
