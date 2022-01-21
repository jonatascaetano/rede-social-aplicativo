import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_dto.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

class PasswordUpdate extends StatefulWidget {
  const PasswordUpdate({Key? key}) : super(key: key);

  @override
  _PasswordUpdateState createState() => _PasswordUpdateState();
}

class _PasswordUpdateState extends State<PasswordUpdate> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<ProfileModel>(
          builder: (context, child, profile) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              "Update password",
              style: TextStyle(
                color: theme.title,
                fontSize: 24.0,
                letterSpacing: 1.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
                child: ListView(
                  children: [
                    TextField(
                      controller: controller1,
                      decoration: const InputDecoration(
                        label: Text("new password"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      controller: controller2,
                      decoration: const InputDecoration(
                        label: Text("confirm the new password"),
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
                        if (controller1.text == controller2.text) {
                          UserDTO userDTO = UserDTO(
                            idUser: profile.userMini.id,
                            name: null,
                            email: null,
                            password: controller2.text,
                            image: null,
                            description: null,
                            place: null,
                            privacy: null,
                            status: null,
                            invitation: null,
                          );
                          profile.updatePassword(
                              userDTO: userDTO, context: context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Try again later')),
                          );
                        }
                      },
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2.0,
                          color: theme.buttonMainText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              profile.load
                  ? Positioned(
                      bottom: 0.1,
                      child: SizedBox(
                        height: 5.0,
                        width: MediaQuery.of(context).size.width,
                        child: const LinearProgressIndicator(),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      });
    });
  }
}
