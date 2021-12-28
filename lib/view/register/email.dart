import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_creation_dto.dart';
import 'package:social_network_application/scoped_model/auxiliar/database_model.dart';

// ignore: must_be_immutable
class Email extends StatefulWidget {
  UserCreationDTO userCreationDTO;
  Email({required this.userCreationDTO, Key? key}) : super(key: key);

  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<DatabaseModel>(
        builder: (context, child, database) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  label: Text("email"),
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.userCreationDTO.email = controller.text;
                  database.checkEmail(
                      userCreationDTO: widget.userCreationDTO,
                      context: context);
                },
                child: const Text("Confirm"),
              ),
            ],
          ),
        ),
      );
    });
  }
}
