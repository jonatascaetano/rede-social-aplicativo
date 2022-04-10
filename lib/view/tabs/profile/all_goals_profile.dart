import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/mini_dto/entity_save_mini.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/widgets/mini_profile/entity_mini_profile_evaluated.dart';

// ignore: must_be_immutable
class AllGoalsProfile extends StatefulWidget {
  List<EntitySaveMini> goals;
  AllGoalsProfile({required this.goals, Key? key}) : super(key: key);

  @override
  _AllGoalsProfileState createState() => _AllGoalsProfileState();
}

class _AllGoalsProfileState extends State<AllGoalsProfile> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "Goals",
            style: TextStyle(
              color: theme.title,
              fontSize: theme.sizeAppBar,
              letterSpacing: theme.letterSpacingAppBar,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            childAspectRatio: 1.0 / 1.0,
            crossAxisCount: 2,
            children: widget.goals.map((e) {
              return Align(alignment: Alignment.topCenter, child: EntityMiniProfileEvaluated(entitySaveMini: e));
            }).toList(),
          ),
        ),
      );
    });
  }
}
