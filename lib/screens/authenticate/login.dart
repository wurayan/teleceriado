import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: ElevatedButton(
        onPressed: ()async{
          dynamic result = await _authService.signInAnonymously();
        }, 
        child: const Text('Login')),
    );
  }
}