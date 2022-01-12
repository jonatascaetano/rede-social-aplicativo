import 'package:flutter/material.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';

// ignore: must_be_immutable
class UpdateEntity extends StatefulWidget {
  EntityMini entityMini;
  BuildContext context;
  UpdateEntity({required this.entityMini, required this.context, Key? key})
      : super(key: key);

  @override
  _UpdateEntityState createState() => _UpdateEntityState();
}

class _UpdateEntityState extends State<UpdateEntity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.entityMini.name),
      ),
    );
  }
}
