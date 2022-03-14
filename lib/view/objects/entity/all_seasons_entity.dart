import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/entity_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/mini_entities/season_mini_entity.dart';

class AllSeasonsEntity extends StatefulWidget {
  const AllSeasonsEntity({Key? key}) : super(key: key);

  @override
  _AllSeasonsEntityState createState() => _AllSeasonsEntityState();
}

class _AllSeasonsEntityState extends State<AllSeasonsEntity> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<EntityModel>(builder: (context, child, entity) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              entity.entityMini.name + " seasons",
              style: TextStyle(
                color: theme.title,
                fontSize: 24.0,
                letterSpacing: 1.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          body: GridView.count(
            childAspectRatio: 1.0 / 1.7,
            crossAxisCount: 2,
            children: entity.seasons.map((e) {
              return SeasonMiniEntity(
                seasonMini: e,
              );
            }).toList(),
          ),
        );
      });
    });
  }
}
