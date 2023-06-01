import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../models/colletion.dart';
import '../firebase_path.dart';
import '../prefs.dart';

class FirebaseCollections {
  Prefs prefs = Prefs();
  FirebasePaths path = FirebasePaths();

  getFavorites() async {
    String collectionPath = await path.getFavoritesPath(); 
    final ref = FirebaseDatabase.instance.ref(collectionPath);
    final snapshot = await ref.get();
    if (snapshot.exists) {
      print("Busca coleção: ${snapshot.value}");
    } else {
      print('Algo deu errado.');
    }
  }

  createCollection(Collection collection) async {
    String collectionPath = await path.getPath("/${collection.nome}/doc");
    DatabaseReference ref = FirebaseDatabase.instance.ref(collectionPath);
    ref.set(collection.toMap());
  }

  getCollection(String collection) async {
    String collectionPath = await path.getPath("/$collection"); 
    final ref = FirebaseDatabase.instance.ref(collectionPath);
    final snapshot = await ref.get();
    if (snapshot.exists) {
      print("Busca coleção: ${snapshot.value}");
    } else {
      print('Algo deu errado.');
    }
  }
}
