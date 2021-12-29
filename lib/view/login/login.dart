import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:social_network_application/scoped_model/login_model.dart';
import 'package:social_network_application/view/register/invitation.dart';

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
    return ScopedModelDescendant<LoginModel>(builder: (context, child, login) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: email,
                decoration: const InputDecoration(
                  label: Text("email"),
                ),
              ),
              TextField(
                controller: password,
                decoration: const InputDecoration(
                  label: Text("password"),
                ),
              ),
              TextButton(
                onPressed: () {
                  login.login(
                      email: email.text,
                      password: password.text,
                      context: context);
                },
                child: const Text("Enter"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Invitation()));
                },
                child: const Text("New account"),
              )
            ],
          ),
        ),
      );
    });
  }
}
