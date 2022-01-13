import 'package:flutter/material.dart';
import 'package:social_network_application/scoped_model/support/language_model.dart';
import 'package:social_network_application/view/datasheet.dart';

// ignore: must_be_immutable
class EntityMiniProfile extends StatefulWidget {
  int index;
  bool isUser;
  String idUser;
  EntityMiniProfile(
      {required this.index,
      required this.isUser,
      required this.idUser,
      Key? key})
      : super(key: key);

  @override
  _EntityMiniProfileState createState() => _EntityMiniProfileState();
}

class _EntityMiniProfileState extends State<EntityMiniProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      width: 80.0,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Datasheet(
                        index: widget.index,
                        isUser: widget.isUser,
                        idUser: widget.idUser,
                      )));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Icon(
                LanguageModel().typeEntitiesIcon[widget.index],
                size: 30.0,
              ),
              backgroundColor: Colors.grey[300],
              radius: 40.0,
            ),
            const SizedBox(height: 8.0),
            Text(
              LanguageModel().typeEntitiesMini[widget.index],
              style: const TextStyle(
                fontSize: 14,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
