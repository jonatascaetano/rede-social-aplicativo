import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_creation_dto.dart';
import 'package:social_network_application/scoped_model/registe_model.dart';

// ignore: must_be_immutable
class Name extends StatefulWidget {
  UserCreationDTO userCreationDTO;
  Name({required this.userCreationDTO, Key? key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<RegisterModel>(
        builder: (context, child, register) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  label: Text("name"),
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.userCreationDTO.name = controller.text;
                  register.checkName(
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
