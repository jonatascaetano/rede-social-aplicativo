import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_dto.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

// ignore: must_be_immutable
class DescriptionUpdate extends StatefulWidget {
  String? description;
  DescriptionUpdate({required this.description, Key? key}) : super(key: key);

  @override
  _DescriptionUpdateState createState() => _DescriptionUpdateState();
}

class _DescriptionUpdateState extends State<DescriptionUpdate> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.description != null) {
      controller.text = widget.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<ProfileModel>(
          builder: (context, child, profile) {
        return Form(
          key: _globalKey,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text(
                "Update description",
                style: TextStyle(
                  color: theme.title,
                  fontSize: theme.sizeAppBar,
                  letterSpacing: theme.letterSpacingAppBar,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 30.0),
                  child: ListView(
                    children: [
                      TextFormField(
                        validator: (value) {
                          return null;
                        },
                        controller: controller,
                        minLines: 10,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          label: Text("description"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.buttonMain,
                          elevation: 0.0,
                        ),
                        onPressed: () {
                          if (_globalKey.currentState!.validate()) {
                            UserDTO userUpdateDTO = UserDTO(
                              idUser: profile.userMini.id,
                              name: null,
                              email: null,
                              password: null,
                              imageProfile: null,
                              description: controller.text,
                              place: null,
                              privacy: null,
                              status: null,
                              invitation: null,
                              release: '',
                            );
                            profile.updateDescription(
                                userUpdateDTO: userUpdateDTO, context: context);
                          }
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            fontSize: theme.sizeButton,
                            letterSpacing: theme.letterSpacingButton,
                            color: theme.buttonMainText,
                            fontWeight: FontWeight.normal,
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
          ),
        );
      });
    });
  }
}
