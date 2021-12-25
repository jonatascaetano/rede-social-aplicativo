import 'package:flutter/material.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';

// ignore: must_be_immutable
class Season extends StatefulWidget {
  SeasonMini seasonMini;
  Season({required this.seasonMini, Key? key}) : super(key: key);

  @override
  _SeasonState createState() => _SeasonState();
}

class _SeasonState extends State<Season> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Season'),
            Text(widget.seasonMini.name),
          ],
        ),
      ),
    );
  }
}
