import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teleceriado/services/prefs.dart';

class FirebasePaths {
  Prefs prefs = Prefs();
  FirebaseFirestore db = FirebaseFirestore.instance;
  String collection = "/usuarios";
  String favoritos = "favoritos";

  Future<String> getUserDoc() async {
    String? userDoc = await prefs.getUserId();
    assert(userDoc!=null);
    return "$collection/$userDoc";
  }
  Future<String> getFavoritesPath() async {
    String path = await getUserDoc();
    return "$path/favoritos";
  }

  Future<String> getUserCollection(String userCollection)async{
    String path = await getUserDoc();
    return "$path/$userCollection";
  }

  Future<String> getPath(String path) async {
    String result = await getUserDoc();
    return "$result$path"; 
  }

  // DatabaseReference ref = FirebaseDatabase.instance.ref("/Usuários/$userDoc/");
    // Map<String, dynamic> filme = {
    //   "nome": "Mad Max",
    //   "ator": "Mel Gibson",
    //   "genero" : "acao",
    //   "temporadas": 5
    // };

    // db.collection("/usuarios")
    // .doc("/WuRayan")
    // .collection("/favoritos")
    // .doc("/madmax").set(filme)
    // .then((value) {
    //   print("Criou alguma coias");
    // }).catchError(
    //   (e) => throw Exception(e)
    // );


  // await Firestore.instance
  //     .collection('/path')
  //     .document("documentPath")
  //     .collection('/subCollectionPath')
  //     .document()
  //     .setData({
  //   'TestData': "Data",
  // }).then((onValue) {
  //   print('Created it in sub collection');
  // }).catchError((e) {
  //   print('======Error======== ' + e);
  // });

    // DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");
    //   await ref.set({
  //     ""
  //     "name": "John",
  //     "age": 18,
  //     "address": {"line1": "100 Mountain View"}
  //   });
}
