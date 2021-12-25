import 'package:flutter/material.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/view/objects/entity.dart';

// ignore: must_be_immutable
class EntityMiniResult extends StatefulWidget {
  EntityMini entityMini;
  EntityMiniResult({required this.entityMini, Key? key}) : super(key: key);

  @override
  _EntityMiniResultState createState() => _EntityMiniResultState();
}

class _EntityMiniResultState extends State<EntityMiniResult> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Entity(entityMini: widget.entityMini)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            widget.entityMini.image != null
                ? CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.entityMini.image.toString()),
                    radius: 30.0,
                  )
                : CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: const Icon(Icons.person),
                    radius: 30.0,
                  ),
            const SizedBox(
              width: 8.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.entityMini.name,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  widget.entityMini.typeEntity.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
