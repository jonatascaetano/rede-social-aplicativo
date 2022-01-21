import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/mini_profile/worker_mini_profile.dart';

class AllWorkersProfile extends StatefulWidget {
  const AllWorkersProfile({Key? key}) : super(key: key);

  @override
  _AllWorkersProfileState createState() => _AllWorkersProfileState();
}

class _AllWorkersProfileState extends State<AllWorkersProfile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<ProfileModel>(
          builder: (context, child, profile) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              profile.userMini.name + " workers",
              style: TextStyle(
                color: theme.title,
                fontSize: 24.0,
                letterSpacing: 1.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          body: GridView.count(
            childAspectRatio: 1.0 / 1.8,
            crossAxisCount: 2,
            children: profile.workers.map((e) {
              return WorkerMiniProfile(
                workerMini: e,
                isUser: true,
              );
            }).toList(),
          ),
        );
      });
    });
  }
}
