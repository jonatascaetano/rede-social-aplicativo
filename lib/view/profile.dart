import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  String id;
  bool user;
  Profile({required this.id, required this.user, Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profile: " + widget.id));
  }
}
