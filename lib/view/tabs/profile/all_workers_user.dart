import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/entities/mini_dto/worker_mini.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/mini_profile/worker_mini_profile.dart';

// ignore: must_be_immutable
class AllWorkersUser extends StatefulWidget {
  bool isUser;
  UserMini userMini;
  List<WorkerMini> workers;
  AllWorkersUser(
      {required this.isUser,
      required this.userMini,
      required this.workers,
      Key? key})
      : super(key: key);

  @override
  _AllWorkersUserState createState() => _AllWorkersUserState();
}

class _AllWorkersUserState extends State<AllWorkersUser> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            widget.userMini.name + " workers",
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
          children: widget.workers.map((e) {
            return WorkerMiniProfile(
              workerMini: e,
              isUser: widget.isUser,
            );
          }).toList(),
        ),
      );
    });
  }
}
