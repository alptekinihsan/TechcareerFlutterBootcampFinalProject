import 'package:flutter/material.dart';
import 'package:bitirmeprojesi/ui/screen/login/body.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: LoginPage(),

    );
  }
}
