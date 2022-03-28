import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/converts/convert_to_enum.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/objects/entity2.dart';

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
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Entity2(
                        entityMini: widget.entityMini,
                        datasheetIsOpen: false,
                      )));
        },
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                widget.entityMini.image != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(widget.entityMini.image!),
                        radius: 30.0,
                      )
                    : CircleAvatar(
                        backgroundColor: theme.shadow,
                        child: Icon(
                          Icons.image,
                          color: theme.emphasis,
                        ),
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
                        style: TextStyle(
                          fontSize: 16,
                          color: theme.title,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Text(
                      LanguageModel().typeEntities[ConvertToEnum.convertTypeEntityToValue(typeEntity: widget.entityMini.typeEntity.toString())],
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.subtitle,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
