import 'package:flutter/material.dart';
import 'package:teleceriado/screens/authenticate/cadastro.dart';
import 'package:teleceriado/screens/authenticate/login.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool showLogin = true;

  void toggleView(){
    setState(() {
      showLogin = !showLogin;
    });
  }



  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return Login(toggleView: toggleView,);
    } else {
      return Cadastro(toggleView: toggleView);
    }
  }
}