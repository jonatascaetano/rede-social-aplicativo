import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_creation_dto.dart';
import 'package:social_network_application/scoped_model/registe_model.dart';

class Invitation extends StatefulWidget {
  const Invitation({Key? key}) : super(key: key);

  @override
  _InvitationState createState() => _InvitationState();
}

class _InvitationState extends State<Invitation> {
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
                  label: Text("invitation"),
                ),
              ),
              TextButton(
                onPressed: () {
                  UserCreationDTO userCreationDTO = UserCreationDTO(
                      name: null,
                      email: null,
                      invitationValue: controller.text,
                      password: null);
                  register.checkInvitation(
                      userCreationDTO: userCreationDTO, context: context);
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
