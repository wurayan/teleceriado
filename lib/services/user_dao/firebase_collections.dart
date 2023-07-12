import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teleceriado/models/error_handler.dart';
import 'package:teleceriado/services/user_dao/firebase_export.dart';
import '../../models/collection.dart';
import '../../models/serie.dart';
import '../prefs.dart';

class FirebaseCollections {
  final Prefs prefs = Prefs();
  final FirebaseSeries _series = FirebaseSeries();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  //GET COLLECTIONS
  Future<List<Collection>> getAllCollections({String? user}) async {
    List<Collection> resultado = [];
    String? userUid = user ?? await prefs.getUserId();
    DocumentSnapshot<Map<String, dynamic>> result = await db
        .collection("/usuarios")
        .doc("/$userUid")
        .get()
        .catchError((e) => throw Exception(e));
    Map<String, dynamic> resultMap = result.data()!;
    List<String> listaColecoes =
        List<String>.from(resultMap["colecoes"] as List);
    
    for (String colecaoNome in listaColecoes) {
      Collection colecao = await getCollectionInfo(colecaoNome,userId: userUid);
      colecao.series = await _series.getCollectionSeries(colecaoNome);
      resultado.add(colecao);
    }
    return resultado;
  }

  Future<Collection> getCollectionInfo(String collectionId,
      {String? userId}) async {
    String? userUid = userId ?? await prefs.getUserId();
    var result = await db
        .collection("/usuarios")
        .doc("/$userUid")
        .collection(collectionId)
        .doc("/doc")
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

  createCollection(Collection collection) async {
    String? userUid = await prefs.getUserId();
    assert(userUid != null);
    var path = db.collection("/usuarios").doc("/$userUid");
    path.set({
      "colecoes": FieldValue.arrayUnion(["${collection.nome}"])
    }, SetOptions(merge: true));
    path
        .collection("/${collection.nome}")
        .doc("/doc")
        .set(collection.toMap())
        .then((value) {})
        .catchError((e) => throw Exception(e));
  }

  createFavorites() async {
    String? userUid = await prefs.getUserId();
    assert(userUid != null);
    var path = db.collection("/usuarios").doc("/$userUid");
    path.set({
      "colecoes": FieldValue.arrayUnion(["Favoritos"]),
      "username": userUid,
    }, SetOptions(merge: true));
    path.collection("/Favoritos").doc("/doc").set({
      "nome": "Favoritos",
      "descricao": "Uma coleção só para suas séries favoritas!",
      "imagemUrl": "https://picsum.photos/900/600"
    }).catchError((e) => throw Exception(e));
  }

  Future<bool> saveInCollection(String collectionId, Serie serie) async {
    String? userUid = await prefs.getUserId();
    Map<String, dynamic> serieMap = {
      "Nome": "${serie.nome}",
      "Poster": "${serie.poster}",
    };
    db
        .collection("/usuarios")
        .doc("/$userUid")
        .collection("/$collectionId")
        .doc("/doc")
        .collection("/series")
        .doc("/${serie.id}")
        .set(serieMap)
        .catchError((e) => throw Exception(e));
    return true;
  }

  Future<bool> removeInCollection(String collectionId, Serie serie) async {
    String? userUid = await prefs.getUserId();
    db.
    collection("/usuarios")
    .doc("/$userUid")
    .collection("/$collectionId")
    .doc("/doc")
    .collection("/series")
    .doc("/${serie.id}")
    .delete()
    .onError((error, stackTrace) {
      ErrorHandler.show(error.toString());
      throw Exception (error);
    });
    return true;
  }

  //GET SERIES


  //GET EPISODIOS
  


}
