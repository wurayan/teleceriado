import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/episodio.dart';
import 'package:teleceriado/models/temporada.dart';
import 'package:teleceriado/services/auth.dart';
import 'package:teleceriado/wrapper.dart';
import 'models/serie.dart';
import 'models/usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Serie()),
        ChangeNotifierProvider(create: (context)=> Episodio()),
        ChangeNotifierProvider(create: (context)=> Temporada())
      ],
      child: const MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Usuario?>.value
      (
      initialData: null,
      value: AuthService().onAuthStateChanged,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'Teleceriado',
          darkTheme: ThemeData(brightness: Brightness.dark),
          themeMode: ThemeMode.dark,
          home: const Wrapper()
        );
      }
    );
  }
}
