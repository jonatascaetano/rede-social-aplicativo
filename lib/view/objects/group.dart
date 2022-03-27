import 'package:flutter/material.dart';
import 'package:social_network_application/entities/mini_dto/group_mini.dart';

// ignore: must_be_immutable
class Group extends StatefulWidget {
  GroupMini groupMini;
  Group({required this.groupMini, Key? key}) : super(key: key);

  @override
  State<Group> createState() => _GroupState();
}

class _GroupState extends State<Group> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.groupMini.name),
      ),
    );
  }
}
