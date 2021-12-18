import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_creation_dto.dart';
import 'package:social_network_application/scoped_model/database_model.dart';

// ignore: must_be_immutable
class Password extends StatefulWidget {
  UserCreationDTO userCreationDTO;
  Password({required this.userCreationDTO, Key? key}) : super(key: key);

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
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
                decoration: InputDecoration(
                  label: widget.userCreationDTO.password == null
                      ? const Text("password")
                      : const Text("Confirm the Password"),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (widget.userCreationDTO.password == null) {
                    widget.userCreationDTO.password = controller.text;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Password(
                                userCreationDTO: widget.userCreationDTO)));
                  } else {
                    database.checkPassword(
                      userCreationDTO: widget.userCreationDTO,
                      password: controller.text,
                      context: context,
                    );
                  }
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
