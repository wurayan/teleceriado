import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/colletion.dart';
import '../../models/serie.dart';
import '../prefs.dart';

class FirebaseCollections {
  Prefs prefs = Prefs();
  FirebaseFirestore db = FirebaseFirestore.instance;

  String initialCollection = "/usuarios";
  String favoritos = "/favoritos";
  String series = "/series";
  String doc = "/doc";

  Future<List<String>> getAllCollections() async {
    String? userUid = await prefs.getUserId();
    DocumentSnapshot<Map<String, dynamic>> result = await db
        .collection(initialCollection)
        .doc("/$userUid")
        .get()
        .catchError((e) => throw Exception(e));
    List<String> listaColecoes = [];
    Map<String, dynamic> resultMap = result.data()!;
    resultMap.forEach((key, value) {
      listaColecoes.add(key);
    });
    return listaColecoes;
  }

  Future<Collection> getCollectionInfo(String collectionId) async {
    String? userUid = await prefs.getUserId();
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

  getCollectionSeries(String collectionId) async {
    String? userUid = await prefs.getUserId();
    List resultList = [];
    var result = await db
        .collection(initialCollection)
        .doc("/$userUid")
        .collection(collectionId)
        .doc(doc)
        .collection(series)
        .get();
    for (var serie in result.docs) {
      resultList.add(serie);
    }
  }

  createCollection(Collection collection) async {
    String? userUid = await prefs.getUserId();
    assert(userUid != null);
    var path = db.collection(initialCollection).doc("/$userUid");
    path.set(
        {"${collection.nome}": "${collection.nome}"}, SetOptions(merge: true));
    path
        .collection("/${collection.nome}")
        .doc(doc)
        .set(collection.toMap())
        .then((value) {
      print("Coleção foi criada com sucesso!");
    }).catchError((e) => throw Exception(e));
  }

  Future<bool> saveInCollection(String collectionId, Serie serie) async {
    String? userUid = await prefs.getUserId();
    Map<String, dynamic> serieMap = {
      "Nome": "${serie.nome}",
      "Poster": "${serie.poster}",
    };
    print("coleção: $collectionId\nserie: $serieMap");
    db
        .collection(initialCollection)
        .doc("/$userUid")
        .collection("/$collectionId")
        .doc(doc)
        .collection(series)
        .doc("/${serie.id}")
        .set(serieMap).catchError((e) => throw Exception(e));
    return true;
  }
  // saveTest(String collectionId) async {
  //   String? userUid = await prefs.getUserId();
  //   Map<String, dynamic> serieMap = {
  //     "Nome": serie.nome,
  //     "Poster": serie.poster,
  //   };
  //   db
  //       .collection(initialCollection)
  //       .doc("/$userUid")
  //       .collection("/$collectionId")
  //       .doc(doc)
  //       .collection(series)
  //       .doc("/${serie.id}")
  //       .set(serieMap).then((value) => print("SALVOU AEHOPOO E TRETATTAAAAA"));
  // }

  docsToSerie() {}

  createFavorites() async {
    String? userUid = await prefs.getUserId();
    assert(userUid != null);
    var path = db.collection(initialCollection).doc("/$userUid");
    path.set(
        {"Favoritos": "Favoritos"}, SetOptions(merge: true));
    path
        .collection("/Favoritos")
        .doc(doc)
        .set({
          "nome":"Favoritos",
          "descricao":"Uma coleção só para suas séries favoritas!",
          "imagemUrl":"https://images.unsplash.com/photo-1593361351718-6b853f7b3431?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80"
        })
        .then((value) {
      print("Coleção foi criada com sucesso!");
    }).catchError((e) => throw Exception(e));
  }
}
