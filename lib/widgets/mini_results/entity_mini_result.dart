import 'package:flutter/material.dart';
import 'package:social_network_application/converts_enum/convert_to_enum.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
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
            widget.entityMini.images.isNotEmpty
                ? CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.entityMini.images[0].toString()),
                    radius: 30.0,
                  )
                : CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: const Icon(Icons.image),
                    radius: 30.0,
                  ),
            const SizedBox(
              width: 8.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200.0,
                  child: Text(
                    widget.entityMini.name,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Text(
                  LanguageModel().typeEntities[
                      ConvertToEnum.convertTypeEntityToValue(
                          typeEntity: widget.entityMini.typeEntity.toString())],
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
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
