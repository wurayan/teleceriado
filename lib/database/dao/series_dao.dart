import 'package:bloco_notas/models/series.dart';
import 'package:sqflite/sqflite.dart';

import '../database.dart';

class SeriesDao {
  Future<List<Series>> findAllSeries() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('series');
    List<Series> seriesList = toList(result);
    return seriesList;
  }

  Future<dynamic> save(Series serie) async {
    final Database db = await getDatabase();
    Map<String, dynamic> seriesMap = toMap(serie);
    return db.insert('series', seriesMap);
  }

  List<Series> toList(List<Map<String, dynamic>> result) {
    final List<Series> seriesList = [];
    for (Map<String, dynamic> row in result) {
      final Series serie = Series(row['id'], row['nome'], row['descricao'], row['imagem']);
      seriesList.add(serie);
    }
    return seriesList;
  }

  Map<String, dynamic> toMap(Series serie) {
    final Map<String, dynamic> serieMap = {};
    serieMap['id'] = serie.id;
    serieMap['nome'] = serie.nome;
    serieMap['descricao'] = serie.descricao;
    serieMap['imagem'] = serie.imagem;
    return serieMap;
  }
}
