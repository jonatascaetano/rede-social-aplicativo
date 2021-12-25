import 'package:flutter/material.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';

// ignore: must_be_immutable
class Entity extends StatefulWidget {
  EntityMini entityMini;
  Entity({required this.entityMini, Key? key}) : super(key: key);

  @override
  _EntityState createState() => _EntityState();
}

class _EntityState extends State<Entity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Entity'),
            Text(widget.entityMini.name),
          ],
        ),
      ),
    );
  }
}
