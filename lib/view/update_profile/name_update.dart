import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_update_dto.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';

// ignore: must_be_immutable
class NameUpdate extends StatefulWidget {
  String? name;
  NameUpdate({required this.name, Key? key}) : super(key: key);

  @override
  _NameUpdateState createState() => _NameUpdateState();
}

class _NameUpdateState extends State<NameUpdate> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.name != null) {
      controller.text = widget.name!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProfileModel>(
        builder: (context, child, profile) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text(
            "Update name",
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
                    controller: controller,
                    decoration: const InputDecoration(
                      label: Text("name"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      UserUpdateDTO userUpdateDTO = UserUpdateDTO(
                          idUser: profile.userMini.id,
                          name: controller.text,
                          email: null,
                          password: null,
                          image: null,
                          description: null,
                          birthDate: null,
                          place: null,
                          privacy: null,
                          status: null);
                      profile.updateName(
                          userUpdateDTO: userUpdateDTO, context: context);
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
