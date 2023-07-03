import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teleceriado/models/snackbar.dart';
import 'package:teleceriado/models/usuario.dart';
import '../../models/collection.dart';
import '../../models/episodio.dart';
import '../../models/serie.dart';
import '../api_service.dart';
import '../prefs.dart';

class FirebaseCollections {
  final ApiService _api = ApiService();
  final Prefs prefs = Prefs();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final String initialCollection = "/usuarios";
  final String favoritos = "/favoritos";
  final String series = "/series";
  final String doc = "/doc";

  Future<Usuario> getUserdata() async {
    String? userUid = await prefs.getUserId();
    DocumentSnapshot<Map<String, dynamic>> result = await db
        .collection(initialCollection)
        .doc("/$userUid")
        .get()
        .catchError((e) => throw Exception(e));
    Map<String, dynamic> resultMap = result.data() ?? {};
    return Usuario(
      uid: userUid,
      username: resultMap["username"],
      avatar: resultMap["avatar"],
    );
  }

  Future<List<String>> getAllCollections({String? user}) async {
    String? userUid = user ?? await prefs.getUserId();
    DocumentSnapshot<Map<String, dynamic>> result = await db
        .collection(initialCollection)
        .doc("/$userUid")
        .get()
        .catchError((e) => throw Exception(e));

    Map<String, dynamic> resultMap = result.data()!;
    List<String> listaColecoes =
        List<String>.from(resultMap["colecoes"] as List);
    // List<String> categoriesList = List<String>.from(map['categories'] as List);
    return listaColecoes;
  }

  Future<Collection> getCollectionInfo(String collectionId,
      {String? userId}) async {
    String? userUid = userId ?? await prefs.getUserId();
    var result = await db
        .collection(initialCollection)
        .doc("/$userUid")
        .collection(collectionId)
        .doc(doc)
        .get();
    Collection collection = Collection();
    if (result.data() != null) {
      Map<String, dynamic> resultMap = result.data()!;
      collection.nome = resultMap["nome"];
      collection.descricao = resultMap["descricao"];
      collection.imagem = resultMap["imagemUrl"];
    }
    return collection;
  }

  Future<List<Serie>> getCollectionSeries(String collectionId) async {
    String? userUid = await prefs.getUserId();
    List<Serie> resultList = [];
    var result = await db
        .collection(initialCollection)
        .doc("/$userUid")
        .collection(collectionId)
        .doc(doc)
        .collection(series)
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

  createCollection(Collection collection) async {
    String? userUid = await prefs.getUserId();
    assert(userUid != null);
    var path = db.collection(initialCollection).doc("/$userUid");
    path.set({
      "colecoes": FieldValue.arrayUnion(["${collection.nome}"])
    }, SetOptions(merge: true));
    print(collection.toMap());
    path
        .collection("/${collection.nome}")
        .doc(doc)
        .set(collection.toMap())
        .then((value) {})
        .catchError((e) => throw Exception(e));
  }

  createFavorites() async {
    String? userUid = await prefs.getUserId();
    assert(userUid != null);
    var path = db.collection(initialCollection).doc("/$userUid");
    path.set({
      "colecoes": FieldValue.arrayUnion(["Favoritos"]),
      "username": userUid,
    }, SetOptions(merge: true));
    path.collection("/Favoritos").doc(doc).set({
      "nome": "Favoritos",
      "descricao": "Uma coleção só para suas séries favoritas!",
      "imagemUrl":
          "https://picsum.photos/900/600"
    }).catchError((e) => throw Exception(e));
  }

  Future<bool> saveInCollection(String collectionId, Serie serie) async {
    String? userUid = await prefs.getUserId();
    Map<String, dynamic> serieMap = {
      "Nome": "${serie.nome}",
      "Poster": "${serie.poster}",
    };
    db
        .collection(initialCollection)
        .doc("/$userUid")
        .collection("/$collectionId")
        .doc(doc)
        .collection(series)
        .doc("/${serie.id}")
        .set(serieMap)
        .catchError((e) => throw Exception(e));
    return true;
  }

  editSerie(Serie serie) async {
    String? userUid = await prefs.getUserId();
    db
        .collection(initialCollection)
        .doc("/$userUid")
        .collection("/editados")
        .doc("/${serie.id}")
        .set(
            serie.descricao == null
                ? {
                    "backdrop": serie.backdrop,
                  }
                : {"descricao": serie.descricao},
            SetOptions(merge: true));
  }

  Future<Map?> getEditedSerie(int serieId, {String? userId}) async {
    String? userUid = userId ?? await prefs.getUserId();
    var res = await db
        .collection(initialCollection)
        .doc("/$userUid")
        .collection("/editados")
        .doc("/$serieId")
        .get();
    return res.data();
  }

  editEpisodio(Episodio episodio) async {
    String? userUid = await prefs.getUserId();
    Map<String, dynamic> editado = {};
    episodio.imagem != null ? editado["imagem"] = episodio.imagem : null;
    episodio.descricao != null
        ? editado["descricao"] = episodio.descricao
        : null;
    episodio.nome != null ? editado["nome"] = episodio.nome : null;
    await db
        .collection(initialCollection)
        .doc("/$userUid")
        .collection("/editados")
        .doc("/${episodio.serieId}")
        .collection("/${episodio.temporada}")
        .doc("/${episodio.numero}")
        .set(editado, SetOptions(merge: true));
  }

  Future<Map<int, Episodio>?> getEditedEpisodio(
      int serieId, int temporada, {String? userId}) async {
    String? userUid = userId ?? await prefs.getUserId();
    Map<int, Episodio> episodios = {};
    var res = await db
        .collection(initialCollection)
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

  Future<List<Serie>> getAllEditedSeries({String? userId}) async {
    var editados = db
        .collection(initialCollection)
        .doc("/$userId")
        .collection("/editados");
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

  updateUserdata({String? username, String? avatar}) async {
    String? userUid = await prefs.getUserId();
    assert(userUid != null);
    Map<String, dynamic> map = {};
    username != null ? map["username"] = username : null;
    avatar != null ? map["avatar"] = avatar : null;
    var path = db.collection(initialCollection).doc("/$userUid");
    path.update(map).onError((error, stackTrace) {
      SnackbarGlobal.show(error.toString());
      throw Exception(error);
    });
  }
}
