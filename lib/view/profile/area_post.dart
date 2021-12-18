import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/database_model.dart';

// ignore: must_be_immutable
class AreaPost extends StatefulWidget {
  String id;
  bool isUser;
  AreaPost({required this.id, required this.isUser, Key? key})
      : super(key: key);

  @override
  _AreaPostState createState() => _AreaPostState();
}

class _AreaPostState extends State<AreaPost> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<DatabaseModel>(
        builder: (context, child, database) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<bool>(
            future: database.getPost(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Container();
                default:
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    return const Center(child: Text("Area post"));
                  }
              }
            }),
      );
    });
  }
}
