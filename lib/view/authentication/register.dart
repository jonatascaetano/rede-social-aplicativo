import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/entities/dto/user_dto.dart';
import 'package:social_network_application/scoped_model/registe_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<RegisterModel>(
          builder: (context, child, register) {
        return Form(
          key: _globalKey,
          child: Scaffold(
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 30.0),
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
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter your invitation';
                          }
                          return null;
                        },
                        controller: invitation,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          label: Text("invitation"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter your first and last name';
                          }
                          return null;
                        },
                        controller: name,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          label: Text("name"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'invalid email';
                          }
                          return null;
                        },
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          label: Text("email"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'enter your password';
                          }
                          if (value.length < 6) {
                            return 'invalid password';
                          }
                          return null;
                        },
                        controller: password,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          label: Text("password"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'confirm The password';
                          }
                          if (value != password.text) {
                            return 'the passwords are different';
                          }
                          return null;
                        },
                        controller: confirm,
                        keyboardType: TextInputType.visiblePassword,
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
                          backgroundColor: theme.buttonMain,
                          elevation: 0.0,
                        ),
                        onPressed: () {
                          if (_globalKey.currentState!.validate()) {
                            UserDTO userDTO = UserDTO(
                              name: name.text,
                              email: email.text,
                              invitation: invitation.text,
                              password: password.text,
                              description: null,
                              idUser: null,
                              imageProfile: null,
                              place: null,
                              privacy: null,
                              status: null,
                              release: DateTime.now().toString(),
                            );
                            register.checkInvitation(
                                userDTO: userDTO, context: context);
                          }
                        },
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            color: theme.buttonMainText,
                            fontSize: theme.sizeButton,
                            letterSpacing: theme.letterSpacingButton,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text:
                              'By clicking confirm you declare that you agree with our ',
                          style: TextStyle(
                            color: theme.subtitle,
                            fontSize: theme.sizeText,
                            letterSpacing: theme.letterSpacingText,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                            text: 'terms of use ',
                            style: TextStyle(
                              color: theme.emphasis,
                              fontSize: theme.sizeText,
                              letterSpacing: theme.letterSpacingText,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                const url =
                                    'https://euteconto-app.blogspot.com/2020/12/termos-de-uso_29.html';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }),
                        TextSpan(
                          text: 'and our ',
                          style: TextStyle(
                            color: theme.subtitle,
                            fontSize: theme.sizeText,
                            letterSpacing: theme.letterSpacingText,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                            text: 'privacy policy',
                            style: TextStyle(
                              color: theme.emphasis,
                              fontSize: theme.sizeText,
                              letterSpacing: theme.letterSpacingText,
                              fontWeight: FontWeight.normal,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                const url =
                                    'https://euteconto-app.blogspot.com/2021/01/politica-de-privacidade.html';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              })
                      ])),
                    ],
                  ),
                ),
                register.load
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
