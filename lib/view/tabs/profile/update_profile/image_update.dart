import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_dto.dart';
import 'package:social_network_application/scoped_model/profile_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';

// ignore: must_be_immutable
class ImageUpdate extends StatefulWidget {
  const ImageUpdate({Key? key}) : super(key: key);

  @override
  _ImageUpdateState createState() => _ImageUpdateState();
}

class _ImageUpdateState extends State<ImageUpdate> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<ProfileModel>(builder: (context, child, profile) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              "Update image",
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
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ListView(
                    children: [
                      !profile.imageIsNull
                          ? Stack(children: [
                              Center(
                                child: Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(profile.imageFile),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                              // Positioned(
                              //     top: 1.0,
                              //     right: 1.0,
                              //     child: IconButton(
                              //       onPressed: () {
                              //         profile.removeImage();
                              //       },
                              //       icon: const Icon(Icons.clear),
                              //     ),)
                            ])
                          : Container(
                              color: theme.shadow,
                              height: 200,
                              child: Center(
                                child: Icon(
                                  Icons.image,
                                  size: 100,
                                  color: theme.emphasis,
                                ),
                              )),
                      const SizedBox(
                        height: 16.0,
                      ),
                      !profile.imageIsNull
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: theme.buttonMain,
                                elevation: 0.0,
                              ),
                              onPressed: () {
                                UserDTO userDTO = UserDTO(idUser: profile.userMini.id, name: null, email: null, password: null, imageProfile: null, description: null, place: null, privacy: null, status: null, invitation: null, release: '');
                                profile.addImageProfile(userDTO: userDTO, context: context);
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
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: theme.button,
                                elevation: 0.0,
                              ),
                              onPressed: () {
                                profile.loadImage();
                              },
                              child: Text(
                                "Select",
                                style: TextStyle(
                                  fontSize: theme.sizeButton,
                                  letterSpacing: theme.letterSpacingButton,
                                  color: theme.buttonText,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                      !profile.imageIsNull
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: theme.button,
                                elevation: 0.0,
                              ),
                              onPressed: () {
                                profile.removeImage();
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontSize: theme.sizeButton,
                                  letterSpacing: theme.letterSpacingButton,
                                  color: theme.buttonText,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
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
