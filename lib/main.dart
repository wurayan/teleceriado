import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/episodio.dart';
import 'package:teleceriado/models/temporada.dart';
import 'package:teleceriado/screens/home/home.dart';
import 'models/serie.dart';

void main() {
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
    return MaterialApp(
      title: 'Teleceriado',
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      home: const Home()
    );
  }
}
