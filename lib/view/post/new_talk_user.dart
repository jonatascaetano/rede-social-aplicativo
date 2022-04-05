import 'package:flutter/material.dart';

class NewTalkUser extends StatefulWidget {
  const NewTalkUser({Key? key}) : super(key: key);

  @override
  State<NewTalkUser> createState() => _NewTalkUserState();
}

class _NewTalkUserState extends State<NewTalkUser> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("New Talk User"),
      ),
    );
  }
}
