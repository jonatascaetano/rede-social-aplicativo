import 'package:flutter/material.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';

// ignore: must_be_immutable
class NewSeasonEntity extends StatefulWidget {
  EntityMini entityMini;
  BuildContext context;
  NewSeasonEntity({required this.entityMini, required this.context, Key? key})
      : super(key: key);

  @override
  _NewSeasonEntityState createState() => _NewSeasonEntityState();
}

class _NewSeasonEntityState extends State<NewSeasonEntity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.entityMini.name),
      ),
    );
  }
}
