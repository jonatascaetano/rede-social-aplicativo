import 'package:flutter/material.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';

// ignore: must_be_immutable
class UpdateSeason extends StatefulWidget {
  SeasonMini seasonMini;
  BuildContext context;
  UpdateSeason({required this.seasonMini, required this.context, Key? key})
      : super(key: key);

  @override
  _UpdateSeasonState createState() => _UpdateSeasonState();
}

class _UpdateSeasonState extends State<UpdateSeason> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.seasonMini.name),
      ),
    );
  }
}
