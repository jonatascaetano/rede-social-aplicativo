import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_update_dto.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';

// ignore: must_be_immutable
class DescriptionUpdate extends StatefulWidget {
  String? description;
  DescriptionUpdate({required this.description, Key? key}) : super(key: key);

  @override
  _DescriptionUpdateState createState() => _DescriptionUpdateState();
}

class _DescriptionUpdateState extends State<DescriptionUpdate> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.description != null) {
      controller.text = widget.description!;
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
            "Update description",
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
                      label: Text("description"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      UserUpdateDTO userUpdateDTO = UserUpdateDTO(
                          idUser: profile.userMini.id,
                          name: null,
                          email: null,
                          password: null,
                          image: null,
                          description: controller.text,
                          birthDate: null,
                          place: null,
                          privacy: null,
                          status: null);
                      profile.updateDescription(
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
