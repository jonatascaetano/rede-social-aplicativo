import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/entity_mini.dart';
import 'package:social_network_application/scoped_model/entity_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

// ignore: must_be_immutable
class UpdateEntity extends StatefulWidget {
  EntityMini entityMini;
  BuildContext context;
  UpdateEntity({required this.entityMini, required this.context, Key? key}) : super(key: key);

  @override
  _UpdateEntityState createState() => _UpdateEntityState();
}

class _UpdateEntityState extends State<UpdateEntity> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<EntityModel>(builder: (context, child, entity) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              'Update ' + widget.entityMini.name,
              style: TextStyle(
                color: theme.title,
                fontSize: 24.0,
                letterSpacing: 1.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: const [],
                ),
              ),
              entity.load
                  ? Positioned(
                      bottom: 0.1,
                      child: SizedBox(
                        height: 5.0,
                        width: MediaQuery.of(context).size.width,
                        child: const LinearProgressIndicator(),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      });
    });
  }
}
