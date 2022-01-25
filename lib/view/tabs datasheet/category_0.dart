import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/datasheet/entity_mini_datasheet.dart';

// ignore: must_be_immutable
class Category0 extends StatefulWidget {
  List<EntitySaveMini> entitySaveMini;
  Category0({required this.entitySaveMini, Key? key}) : super(key: key);

  @override
  _Category0State createState() => _Category0State();
}

class _Category0State extends State<Category0> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Scaffold(
        body: GridView.count(
          childAspectRatio: 1.0 / 1.5,
          crossAxisCount: 2,
          children: widget.entitySaveMini.map((e) {
            return EntityMiniDatasheet(entitySaveMini: e);
          }).toList(),
        ),
      );
    });
  }
}
