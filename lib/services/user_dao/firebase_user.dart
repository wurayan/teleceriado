import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/snackbar.dart';
import '../../models/usuario.dart';
import '../prefs.dart';

class FirebaseUsers {
  final Prefs prefs = Prefs();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Usuario> getUserdata({String? userId}) async {
    String? userUid = userId ?? _auth.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> result = await db
        .collection("/usuarios")
        .doc("/$userUid")
        .get()
        .catchError((e) => throw Exception(e));
    Map<String, dynamic> resultMap = result.data() ?? {};
    return Usuario(
      uid: userUid,
      username: resultMap["username"],
      avatar: resultMap["avatar"],
      bio: resultMap["bio"],
      seguidoresQtde: resultMap["seguidoresQtde"],
      seguidores: List<String>.from(resultMap["seguidores"] ?? <String>[]),
      editados: resultMap["editadosQtde"],
      assistindoAgora: resultMap["assistindoAgora"],
      serieFavorita: resultMap["serieFavorita"],
    );
  }

  updateUsername(String newUsername) {
    String userUid = _auth.currentUser!.uid;
     db.collection("/usuarios").doc("/$userUid").update({
      "username" : newUsername
    }).onError((error, stackTrace) => throw Exception(error));
  }

  updateDescricao(String newDescricao) {
    String userUid = _auth.currentUser!.uid;
    db.collection("/usuarios").doc("/$userUid").update({
      "descricao": newDescricao
    }).onError((error, stackTrace) => throw Exception(error));
  }

  updateAvatar(String url){
    String userUid = _auth.currentUser!.uid;
    db.collection("/usuarios").doc("/$userUid").update({
      "avatar": url
    }).onError((error, stackTrace) => throw Exception(error));
  }

  saveFavorita(int serieId) async {
    String? userUid = _auth.currentUser!.uid;
    db
        .collection("/usuarios")
        .doc("/$userUid")
        .update({"serieFavorita": serieId});
  }

  saveAssistindoAgora(int serieId) async {
    String? userUid = _auth.currentUser!.uid;
    db
        .collection("/usuarios")
        .doc("/$userUid")
        .update({"assistindoAgora": serieId});
  }
}
