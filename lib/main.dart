import 'package:bloco_notas/models/series.dart';
import 'package:bloco_notas/screens/add_episodios_screen.dart';
import 'package:bloco_notas/screens/add_serie_screen.dart';
import 'package:bloco_notas/screens/feed_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        initialRoute: "feed",
        routes: {
          'feed': (context) => FeedScreen(),
          'addSerie': (context) => SeriesForm(),
          // 'feedEpisodios': (context) => FeedEpisodiosScreen(),
        },
        onGenerateRoute: (routesettings) {
          if (routesettings.name == 'addEpisodios') {
            final Series serie = routesettings.arguments as Series;
            return MaterialPageRoute(builder: (context) {
              return AddEpisodiosForm(serie: serie,);
            });
          }
        });
  }
}
