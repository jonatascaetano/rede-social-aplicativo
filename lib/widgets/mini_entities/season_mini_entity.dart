import 'package:flutter/material.dart';
import 'package:social_network_application/entities/mini_dto/season_mini.dart';
import 'package:social_network_application/view/objects/season.dart';

// ignore: must_be_immutable
class SeasonMiniEntity extends StatefulWidget {
  SeasonMini seasonMini;
  SeasonMiniEntity({required this.seasonMini, Key? key}) : super(key: key);

  @override
  _SeasonMiniEntityState createState() => _SeasonMiniEntityState();
}

class _SeasonMiniEntityState extends State<SeasonMiniEntity> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 150.0,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffce93d8)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              widget.seasonMini.images.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.seasonMini.images[0].toString()),
                      radius: 30.0,
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: const Icon(
                        Icons.image,
                        size: 30.0,
                      ),
                      radius: 30.0,
                    ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                widget.seasonMini.name,
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                'Episodes ' + widget.seasonMini.episodeQuantity.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13.0,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Season(seasonMini: widget.seasonMini)));
                },
                child: const Text("view"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
