import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/screens/authenticate/auth.dart';
import 'package:teleceriado/screens/home/home.dart';
import 'models/usuario.dart';
import 'models/version.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  
  
  getPackage(context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Provider.of<Version>(context, listen: false).version = packageInfo.version;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<Usuario?>(context);
    if (usuario == null) {
      return const Auth();
    } else {
      getPackage(context);
      //TODO aqui podemos colocar a verificão de firstTime e redirecionar para uma tela de personalização de usuário
      return const Home();
    }
  }
}
