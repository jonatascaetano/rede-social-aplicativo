import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_update_dto.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';

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
    return ScopedModelDescendant<ProfileModel>(
        builder: (context, child, profile) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text(
            "Update password",
            style: TextStyle(
              color: Colors.purple,
            ),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: controller1,
                    decoration: const InputDecoration(
                      label: Text("password"),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: controller2,
                    decoration: const InputDecoration(
                      label: Text("confirm the password"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (controller1.text == controller2.text) {
                        UserUpdateDTO userUpdateDTO = UserUpdateDTO(
                            idUser: profile.userMini.id,
                            name: null,
                            email: null,
                            password: controller2.text,
                            image: null,
                            description: null,
                            birthDate: null,
                            place: null,
                            privacy: null,
                            status: null);
                        profile.updatePassword(
                            userUpdateDTO: userUpdateDTO, context: context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Try again later')),
                        );
                      }
                    },
                    child: const Text("Confirm"),
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
  }
}
