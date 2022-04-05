import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NewTalkGroup extends StatefulWidget {
  String idGroup;
  NewTalkGroup({required this.idGroup, Key? key}) : super(key: key);

  @override
  State<NewTalkGroup> createState() => _NewTalkGroupState();
}

class _NewTalkGroupState extends State<NewTalkGroup> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("New Talk Group"),
      ),
    );
  }
}
