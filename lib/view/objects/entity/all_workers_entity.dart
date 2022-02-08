import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/entity_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/mini_entities/worker_mini_entity.dart';

class AllWorkersEntity extends StatefulWidget {
  const AllWorkersEntity({Key? key}) : super(key: key);

  @override
  _AllWorkersEntityState createState() => _AllWorkersEntityState();
}

class _AllWorkersEntityState extends State<AllWorkersEntity> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<EntityModel>(
          builder: (context, child, entity) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              entity.entityMini.name + " cast",
              style: TextStyle(
                color: theme.title,
                fontSize: 24.0,
                letterSpacing: 1.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          body: GridView.count(
            childAspectRatio: 1.0 / 1.65,
            crossAxisCount: 2,
            children: entity.workers.map((e) {
              return WorkerMiniEntity(
                workerMini: e,
                idUser: entity.idUser,
              );
            }).toList(),
          ),
        );
      });
    });
  }
}
