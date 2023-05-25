import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/screens/authenticate/auth.dart';
import 'package:teleceriado/screens/home/home.dart';

import 'models/usuario.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<Usuario?>(context);
    if (usuario == null) {
      return const Auth();
    } else {
      return const Home();
    }
  }
}
