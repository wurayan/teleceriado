import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/colletion.dart';
import '../../models/serie.dart';
import '../firebase_path.dart';
import '../prefs.dart';

class FirebaseCollections {
  Prefs prefs = Prefs();
  FirebasePaths path = FirebasePaths();
  FirebaseFirestore db = FirebaseFirestore.instance;

  String initialCollection = "/usuarios";
  String favoritos = "/favoritos";
  String series = "/series";
  String doc = "/doc";

  getCollectionInfo(String collectionId) async {
    String? userUid = await prefs.getUserId();
    var result = await db.collection(initialCollection)
    .doc("/$userUid")
    .collection(collectionId)
    .doc(doc)
    .get();
  }

  getCollectionSeries(String collectionId) async {
    String? userUid = await prefs.getUserId();
    List resultList = [];
    var result = await db.collection(initialCollection)
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
    assert(userUid!=null);
    db.collection(initialCollection)
    .doc("/$userUid")
    .collection("/${collection.nome}")
    .doc(doc).set(collection.toMap())
    .then((value) {
      print("Coleção foi criada com sucesso!");
    }).catchError(
      (e) => throw Exception(e)
    );
  }

  saveInCollection(String collectionId, Serie serie) async {
    String? userUid = await prefs.getUserId();

    Map<String, dynamic> serieMap = {
      "Nome":serie.nome,
      "Poster": serie.poster,
    };
    
    db.collection(initialCollection)
    .doc("/$userUid")
    .collection("/$collectionId")
    .doc(doc)
    .collection(series)
    .doc("/${serie.id}")
    .set(serieMap);
    
  }

  docsToSerie(){}


}
