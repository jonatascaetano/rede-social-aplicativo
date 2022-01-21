import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_dto.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

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
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<ProfileModel>(
          builder: (context, child, profile) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              "Update name",
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
                      controller: controller,
                      decoration: const InputDecoration(
                        label: Text("name"),
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
                          idUser: profile.userMini.id,
                          name: controller.text,
                          email: null,
                          password: null,
                          image: null,
                          description: null,
                          place: null,
                          privacy: null,
                          status: null,
                          invitation: null,
                        );
                        profile.updateName(userDTO: userDTO, context: context);
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
