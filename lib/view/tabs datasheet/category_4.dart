import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';
import 'package:social_network_application/scoped_model/category_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/datasheet/entity_mini_datasheet.dart';

// ignore: must_be_immutable
class Category4 extends StatefulWidget {
  List<EntitySaveMini> entitySaveMini;
  Category4({required this.entitySaveMini, Key? key}) : super(key: key);

  @override
  _Category4State createState() => _Category4State();
}

class _Category4State extends State<Category4> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModel<CategoryModel>(
          model: CategoryModel(entitySaveMinis: widget.entitySaveMini, category: 4),
          child: ScopedModelDescendant<CategoryModel>(builder: (context, child, category) {
            return Stack(
              children: [
                Scaffold(
                  body: category.entitySaves.isEmpty
                      ? Container()
                      : GridView.count(
                          padding: EdgeInsets.zero,
                          childAspectRatio: 1.0 / 1.5,
                          crossAxisCount: 2,
                          children: category.entitySaves.map((e) {
                            return EntityMiniDatasheet(entitySaveMini: e);
                          }).toList(),
                        ),
                ),
                category.load
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
            );
          }));
    });
  }
}
