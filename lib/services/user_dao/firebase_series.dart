import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/error_handler.dart';
import '../../models/serie.dart';
import '../api_service.dart';
import '../prefs.dart';

class FirebaseSeries {
  final Prefs prefs = Prefs();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final ApiService _api = ApiService();

  Future<List<Serie>> getCollectionSeries(String collectionId,
      {String? userId}) async {
    String? userUid = userId ?? await prefs.getUserId();
    List<Serie> resultList = [];
    var result = await db
        .collection("/usuarios")
        .doc("/$userUid")
        .collection(collectionId)
        .doc("/doc")
        .collection("/series")
        .get();
    for (var elemento in result.docs) {
      Map serieMap = elemento.data();
      Serie serie = Serie();
      serie.id = int.parse(elemento.id);
      serie.nome = serieMap["Nome"];
      serie.poster = serieMap["Poster"];
      resultList.add(serie);
    }
    return resultList;
  }

  Future<bool> editSerie(Serie serie) async {
    String? userUid = await prefs.getUserId();
    db
        .collection("/usuarios")
        .doc("/$userUid")
        .collection("/editados")
        .doc("/${serie.id}")
        .set(
            serie.descricao == null
                ? {"backdrop": serie.backdrop}
                : {"descricao": serie.descricao},
            SetOptions(merge: true))
        .catchError((e) {
      ErrorHandler.show(e.toString());
    });
    return true;
  }

  Future<Map?> getEditedSerie(int serieId, {String? userId}) async {
    String? userUid = userId ?? await prefs.getUserId();
    var res = await db
        .collection("/usuarios")
        .doc("/$userUid")
        .collection("/editados")
        .doc("/$serieId")
        .get();
    return res.data();
  }

  Future<List<Serie>> getAllEditedSeries({String? userId}) async {
    var editados =
        db.collection("/usuarios").doc("/$userId").collection("/editados");
    var res = await editados.get();
    List<Serie> series = [];
    for (var serie in res.docs) {
      var editado = await editados.doc("/${serie.id}").get();
      Map? edicao = editado.data();
      Serie apiSerie = await _api.getSerie(int.parse(serie.id), 1);
      //Se edicao retornar nulo, então nãO tem edições na série e ja retornamos a apiSerie
      if (edicao == null) {
        series.add(apiSerie);
      } else {
        String? backdrop = edicao["backdrop"];
        String? descricao = edicao["descricao"];
        Serie resultado = Serie();
        if (backdrop != null && descricao != null) {
          resultado =
              apiSerie.copyWith(backdrop: backdrop, descricao: descricao);
        } else if (backdrop != null && descricao == null) {
          resultado = apiSerie.copyWith(backdrop: backdrop);
        } else {
          resultado = apiSerie.copyWith(descricao: descricao);
        }
        series.add(resultado);
      }
    }
    return series;
  }

    Future<bool> isFavorite(int serieId) async {
   String? userId = await prefs.getUserId();
   var res = await db
   .collection("/usuarios")
   .doc("/$userId")
   .collection("Favoritos")
   .doc("/doc")
   .collection("/series")
   .doc("/$serieId")
   .get();
   return res.data()!=null;
  }
}
