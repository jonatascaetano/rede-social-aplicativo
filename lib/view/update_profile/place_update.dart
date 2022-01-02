import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_update_dto.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';

// ignore: must_be_immutable
class PlaceUpdate extends StatefulWidget {
  String? place;
  PlaceUpdate({required this.place, Key? key}) : super(key: key);

  @override
  _PlaceUpdateState createState() => _PlaceUpdateState();
}

class _PlaceUpdateState extends State<PlaceUpdate> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.place != null) {
      controller.text = widget.place!;
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
            "Update place",
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
                      label: Text("place"),
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
                          description: null,
                          birthDate: null,
                          place: controller.text,
                          privacy: null,
                          status: null);
                      profile.updatePlace(
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
