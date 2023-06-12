import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teleceriado/models/snackbar.dart';
import 'package:teleceriado/models/usuario.dart';
import '../../models/collection.dart';
import '../../models/episodio.dart';
import '../../models/serie.dart';
import '../prefs.dart';

class FirebaseCollections {
  Prefs prefs = Prefs();
  FirebaseFirestore db = FirebaseFirestore.instance;
  String initialCollection = "/usuarios";
  String favoritos = "/favoritos";
  String series = "/series";
  String doc = "/doc";

  Future<String> getUsername() async {
    String? userUid = await prefs.getUserId();
    DocumentSnapshot<Map<String, dynamic>> result = await db
        .collection(initialCollection)
        .doc("/$userUid")
        .get()
        .catchError((e) => throw Exception(e));
    Map<String, dynamic> resultMap = result.data()!;
    return resultMap["username"];
  }

  Future<List<String>> getAllCollections() async {
    String? userUid = await prefs.getUserId();
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
    path
        .collection("/${collection.nome}")
        .doc(doc)
        .set(collection.toMap())
        .then((value) {
      print("Coleção foi criada com sucesso!");
    }).catchError((e) => throw Exception(e));
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
          "https://images.unsplash.com/photo-1593361351718-6b853f7b3431?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80"
    }).then((value) {
      print("Coleção foi criada com sucesso!");
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
          serie.descricao==null
          ? {
           "backdrop": serie.backdrop,
           }
          :{
           "descricao": serie.descricao
          },
        SetOptions(merge: true));
  }

  Future<Map?> getEditedSerie(int serieId) async {
    String? userUid = await prefs.getUserId();
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
    var res = await db
        .collection(initialCollection)
        .doc("/$userUid")
        .collection("/editados")
        .doc("/${episodio.serieId}")
        .collection("/${episodio.temporada}")
        .doc("/${episodio.numero}")
        .set(
          {
            "imagem": episodio.imagem,
            "descricao": episodio.descricao,
          },
          SetOptions(
            merge: true
          )
        );
  }

  Future<Map?> getEditedEpisodio(int serieId, int temporada) async {
    String? userUid = await prefs.getUserId();
    var res = await db
        .collection(initialCollection)
        .doc("/$userUid")
        .collection("/editados")
        .doc("/$serieId")
        .collection("/$temporada")
        .get();
    for (var element in res.docs) {
      Map elementMap = element.data();
      if (elementMap["descricao"]!=null || elementMap["imagem"]!=null) {
        Episodio episodio = Episodio();
        episodio.id = int.parse(element.id);
        episodio.nome = elementMap["nome"];
        episodio.numero = elementMap["numero"];

      }
    }
  }

  updateUsername(String username) async {
    String? userUid = await prefs.getUserId();
    assert(userUid != null);
    var path = db.collection(initialCollection).doc("/$userUid");
    path.update({"username": username}).onError((error, stackTrace) {
      SnackbarGlobal.show(error.toString());
      throw Exception(error);
    });
  }

  getData() async {
    var result = await db.collection(initialCollection).doc("/WuRayan").get();
    Map<String, dynamic> resultMap = result.data()!;
    print("resultado: $resultMap");
    List<dynamic> colecoes = resultMap["colecoes"];
    print(colecoes);
  }

  setData() async {
    var result = await db.collection(initialCollection).doc("/WuRayan").set({
      "colecoes": FieldValue.arrayUnion(["Favoritos", "odiados"])
    }, SetOptions(merge: true));
  }

  addData() async {
    var result = await db.collection(initialCollection).doc("/WuRayan").set({
      "colecoes": FieldValue.arrayUnion(["outra lista", "teste"])
    }, SetOptions(merge: true));
  }

  removeData() async {
    var result = await db.collection(initialCollection).doc("/WuRayan").update(
      {
        "colecoes": FieldValue.arrayRemove(["Favoritos", "teste"])
      },
    );
  }

  updateUi(Function reload) async {
    String? userUid = await prefs.getUserId();
    db.collection(initialCollection).doc("/$userUid").snapshots().listen(
        (event) {
      reload();
    }, onError: (e) => throw Exception(e));
  }
}
