import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/login_model.dart';
import 'package:social_network_application/scoped_model/support/theme_model.dart';
import 'package:social_network_application/view/authentication/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, theme) {
      return ScopedModelDescendant<LoginModel>(
          builder: (context, child, login) {
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: theme.buttonMain,
                        elevation: 0.0,
                      ),
                      onPressed: () {
                        login.login(
                            email: email.text,
                            password: password.text,
                            context: context);
                      },
                      child: Text(
                        "Enter",
                        style: TextStyle(
                          color: theme.buttonMainText,
                          fontSize: 19,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: theme.button,
                        elevation: 0.0,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Invitation()));
                      },
                      child: Text(
                        "New account",
                        style: TextStyle(
                          color: theme.buttonText,
                          fontSize: 19,
                          letterSpacing: 1.5,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              login.load
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
