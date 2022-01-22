import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_dto.dart';
import 'package:social_network_application/scoped_model/registe_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

class Invitation extends StatefulWidget {
  const Invitation({Key? key}) : super(key: key);

  @override
  _InvitationState createState() => _InvitationState();
}

class _InvitationState extends State<Invitation> {
  TextEditingController invitation = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<RegisterModel>(
          builder: (context, child, register) {
        return Scaffold(
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
            //marlbfd6
            child: ListView(
              children: [
                Text(
                  "Bundle",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.title,
                    fontSize: 36,
                    letterSpacing: 4.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: invitation,
                  decoration: const InputDecoration(
                    label: Text("invitation"),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: name,
                  decoration: const InputDecoration(
                    label: Text("name"),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: email,
                  decoration: const InputDecoration(
                    label: Text("email"),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: password,
                  decoration: const InputDecoration(
                    label: Text("password"),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: confirm,
                  decoration: const InputDecoration(
                    label: Text("confirm password"),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: theme.buttonMain,
                    elevation: 0.0,
                  ),
                  onPressed: () {
                    UserDTO userDTO = UserDTO(
                      name: name.text,
                      email: email.text,
                      invitation: invitation.text,
                      password: password.text,
                      description: null,
                      idUser: null,
                      image: null,
                      place: null,
                      privacy: null,
                      status: null,
                    );
                    register.checkInvitation(
                        userDTO: userDTO, context: context);
                  },
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                      color: theme.buttonMainText,
                      fontSize: 19,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
