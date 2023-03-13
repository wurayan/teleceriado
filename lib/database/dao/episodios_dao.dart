import 'package:bloco_notas/models/episodios.dart';
import 'package:bloco_notas/models/series.dart';
import 'package:sqflite/sqflite.dart';

import '../database.dart';

class EpisodiosDao {
  //TODO ARRUAMR PARA ELE LOCALIZAR DE ACORDO COM A ID DA SERIE
  Future<List<Series>> findAllEpisodes(String id) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query('series');
    List<Series> seriesList = toList(result);
    return seriesList;
  }

  Future<dynamic> saveEp(Episodios episodio) async {
    final Database db = await getDatabase();
    Map<String, dynamic> episodioMap = toMap(episodio);
    return db.insert('episodios', episodioMap);
  }

  List<Series> toList(List<Map<String, dynamic>> result) {
    //TODO ARRUAMR O TOLIST
    final List<Series> seriesList = [];
    for (Map<String, dynamic> row in result) {
      final Series serie = Series(row['id'], row['nome'], row['descricao'], row['imagem']);
      seriesList.add(serie);
    }
    return seriesList;
  }

  Map<String, dynamic> toMap(Episodios episodio) {
    final Map<String, dynamic> episodioMap = {};
    episodioMap['id'] = episodio.id;
    episodioMap['nome'] = episodio.nome;
    episodioMap['descricao'] = episodio.descricao;
    episodioMap['imagem'] = episodio.imagem;
    episodioMap['serieId'] = episodio.serieId;
    return episodioMap;
  }
}
