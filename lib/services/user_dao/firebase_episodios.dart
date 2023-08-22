import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/episodio.dart';
import '../api_service.dart';
import '../prefs.dart';

class FirebaseEpisodios {
  final Prefs prefs = Prefs();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final ApiService _api = ApiService();

  editEpisodio(Episodio episodio) async {
    String? userUid = await prefs.getUserId();
    Map<String, dynamic> editado = episodioToMap(episodio);
    var path = db.doc("/usuarios/$userUid/editados/${episodio.serieId}");
    var temporada = await path.get();
    Map? map = temporada.data();
    if (map?["temporadas"] == null || map?["temporadas"] < episodio.temporada) {
      await path.set(
        {"temporadas": episodio.temporada, "nome": episodio.serie},
        SetOptions(merge: true),
      );
    }
    var fullPath =
        path.collection("/${episodio.temporada}").doc("/${episodio.numero}");
    await fullPath
        .set(
      editado,
      SetOptions(merge: true),
    )
        .then((value) {
      db
          .doc("/usuarios/$userUid")
          .update({"editadosQtde": FieldValue.increment(1)});
      db.collection("/comentarios").doc("/${episodio.id}$userUid").set({
        "episodio": episodio.id,
        "publicado": DateTime.now(),
        "path": fullPath,
        "usuario": userUid,
        "serie": episodio.serieId,
        "temporada": episodio.temporada,
        "numero": episodio.numero
      }, SetOptions(merge: true));
    });
  }

  Future<Map<int, Episodio>?> getEditedEpisodio(int serieId, int temporada,
      {String? userId}) async {
    String? userUid = userId ?? await prefs.getUserId();
    Map<int, Episodio> episodios = {};
    var res = await db
        .collection("/usuarios")
        .doc("/$userUid")
        .collection("/editados")
        .doc("/$serieId")
        .collection("/$temporada")
        .get();

    for (var element in res.docs) {
      Episodio episodio = Episodio();
      episodio.imagem = element.data()["imagem"];
      episodio.descricao = element.data()["descricao"];
      episodio.nome = element.data()["nome"];
      episodios[int.parse(element.id)] = episodio;
    }
    return episodios;
  }

  Future<List<Episodio>> getAllEditedEpisodios(String userId) async {
    List<Episodio> apiEpisodios;
    List<Episodio> resultado = [];
    var path =
        db.collection("/usuarios").doc("/$userId").collection("/editados");
    var series = await path.get();
    for (var item in series.docs) {
      var pathToSerie = path.doc(item.id);
      var serieMap = await pathToSerie.get();
      if (serieMap.data() != null) {
        Map map = serieMap.data()!;
        int temporadas = map["temporadas"];
        for (var i = 1; i <= temporadas; i++) {
          apiEpisodios = await _api.getEpisodios(int.parse(item.id), i);
          var episodiosEditados = await pathToSerie.collection("/$i").get();
          int index = 0;
          for (var episodioData in episodiosEditados.docs) {
            Map episodioMap = episodioData.data();
            Episodio episodio = apiEpisodios[index];
            episodio.nome = episodioMap["nome"] ?? episodio.nome;
            episodio.descricao = episodioMap["descricao"] ?? episodio.descricao;
            if (episodioMap["imagem"] != null) {
              episodio.imagem = episodioMap["imagem"];
              episodio.wasEdited = true;
            }
            resultado.add(episodio);
            index += 1;
          }
        }
      }
    }
    return resultado;
  }

  Map<String, dynamic> episodioToMap(Episodio episodio) {
    Map<String, dynamic> map = {};
    if (episodio.descricao != null) map["descricao"] = episodio.descricao;
    if (episodio.nome != null) map["nome"] = episodio.nome;
    return map;
  }
}
