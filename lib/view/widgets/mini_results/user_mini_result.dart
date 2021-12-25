import 'package:flutter/material.dart';
import 'package:social_network_application/entities/mini_dto/user_mini.dart';
import 'package:social_network_application/scoped_model/language_model.dart';
import 'package:social_network_application/view/objects/user.dart';

// ignore: must_be_immutable
class UserMiniResult extends StatefulWidget {
  UserMini userMini;
  UserMiniResult({required this.userMini, Key? key}) : super(key: key);

  @override
  _UserMiniResultState createState() => _UserMiniResultState();
}

class _UserMiniResultState extends State<UserMiniResult> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => User(
                      isUser: false,
                      userMini: widget.userMini,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            widget.userMini.image != null
                ? CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.userMini.image.toString()),
                    radius: 30.0,
                  )
                : CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: const Icon(Icons.person),
                    radius: 30.0,
                  ),
            const SizedBox(
              width: 8.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userMini.name,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  LanguageModel().typeObject[0],
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
