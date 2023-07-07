import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/usuario.dart';
import '../prefs.dart';

class FirebaseComunidade {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final Prefs prefs = Prefs();

  Future<List<Usuario>> getUsuarios() async {
    var res = await db.collection("/usuarios").get();
    

    List<Usuario> usuariosList = [];
    for (var docs in res.docs) {
        Map<String, dynamic> data = docs.data();
        Usuario usuario = Usuario();
        usuario.uid = docs.id;
        usuario.username = data["username"];
        usuario.avatar = data["avatar"];
        usuario.bio = data["bio"];
        usuariosList.add(usuario);
    }
    return usuariosList;
  }

  Future<List<String>> getUsuariosSeguindo() async {
    String? userUid = await prefs.getUserId();
    var res = await db
    .collection("/usuarios")
    .doc("/$userUid")
    .get();
    List<String> listaSeguindo = [];
    Map<String, dynamic> resultMap = res.data()!;
    if (resultMap["seguindoUsuarios"]!=null) {
      listaSeguindo= List<String>.from(resultMap["seguindoUsuarios"] as List);
    }
    return listaSeguindo;
  }

  Future<List<String>> getColecoesSeguindo() async {
    final String? userUid = await prefs.getUserId();
    var res = await db
    .collection("/usuarios")
    .doc("/$userUid")
    .get();
    Map<String, dynamic> resultMap = res.data()!;
    List<String> listaSeguindo = [];
    if (resultMap["seguindoColecoes"]!=null) {
     listaSeguindo = List<String>.from(resultMap["seguindoColecoes"] as List); 
    }
    return listaSeguindo;
  }

  seguirUsuario(String usuarioId, bool seguir) async {
    final String? userUid = await prefs.getUserId();
    await db
    .collection("/usuarios")
    .doc("/$userUid")
    .set(
      {"seguindoUsuarios" : 
      seguir
      ? FieldValue.arrayUnion([usuarioId])
      : FieldValue.arrayRemove([usuarioId])},
      SetOptions(merge: true)
    );
  }

  seguirColecao(String colecaoId, bool seguir) async {
    final String? userUid = await prefs.getUserId();
    await db
    .collection("/usuarios")
    .doc("/$userUid")
    .set(
      {"seguindoColecoes" : 
      seguir
      ? FieldValue.arrayUnion([colecaoId])
      : FieldValue.arrayRemove([colecaoId])},
      SetOptions(merge: true)
    );
  }

  isFollowing({String? usuarioId, String? colecaoId}) async {
    if(usuarioId==null&&colecaoId==null) return;
    List<String> seguindo = [];
    if (usuarioId!=null) {
      seguindo = await getUsuariosSeguindo();
    }
    else if (colecaoId!=null) {
      seguindo = await getColecoesSeguindo();
    }
    bool isFollowing = seguindo.contains(usuarioId) | seguindo.contains(colecaoId);
    print("TA SEGUINDO? $isFollowing");
    return isFollowing;
  }
}
