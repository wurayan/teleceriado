import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/collection.dart';
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

  Future<List<Usuario>> getUsuariosSeguindo() async {
    String? userUid = await prefs.getUserId();
    var res = await db
        .collection("/usuarios")
        .doc("/$userUid")
        .collection("/seguindoUsuarios")
        .get();
    List<Usuario> userList = [];
    for (var doc in res.docs) {
      Map data = doc.data();
      Usuario user = Usuario();
      user.uid = data["uid"];
      user.username = data["username"];
      user.avatar = data["avatar"];
      userList.add(user);
    }
    return userList;
  }

  Future<List<Collection>> getColecoesSeguindo() async {
    final String? userUid = await prefs.getUserId();
    var res = await db
        .collection("/usuarios")
        .doc("/$userUid")
        .collection("/seguindoColecoes")
        .get();

    List<Collection> collectionList = [];
    for (var doc in res.docs) {
      Map data = doc.data();
      Collection colecao = Collection();
      colecao.nome = data["nome"];
      colecao.imagem = data["imagem"];
      colecao.dono = data["dono"];
      collectionList.add(colecao);
    }
    return collectionList;
  }

  seguirUsuario(Usuario usuario, bool seguir) async {
    final String? userUid = await prefs.getUserId();
    Map<String, dynamic> map = {
      "uid": usuario.uid,
      "username": usuario.username,
      "avatar": usuario.avatar
    };
    var path = db
        .collection("/usuarios")
        .doc("/$userUid")
        .collection("/seguindoUsuarios")
        .doc("/${usuario.uid}");
    var seguidores = db.collection("/usuarios").doc("/${usuario.uid}");

    seguir
        ? path.set(map).then((value) {
            seguidores.set(
              {
                "seguidores": FieldValue.arrayUnion(["$userUid"])
              },
              SetOptions(merge: true),
            );
            seguidores.update({"seguidoresQtde": FieldValue.increment(1)});
          })
        : path.delete().then((value) {
          seguidores.set(
              {
                "seguidores": FieldValue.arrayRemove(["$userUid"])
              },
              SetOptions(merge: true),
            );
            seguidores.update({"seguidoresQtde": FieldValue.increment(-1)});
        });
  }

  seguirColecao(Collection colecao, bool seguir) async {
    final String? userUid = await prefs.getUserId();
    Map<String, dynamic> map = {
      "nome": colecao.nome,
      "imagem": colecao.imagem,
      "dono": colecao.dono,
    };
    var path = db
        .collection("/usuarios")
        .doc("/$userUid")
        .collection("/seguindoColecoes")
        .doc("/${colecao.nome}${colecao.dono}");

    seguir ? path.set(map) : path.delete();
  }

  Future<bool> isFollowingUsuario(String usuarioId) async {
    List<Usuario> seguindo = await getUsuariosSeguindo();
    return seguindo.map((item) => item.uid).contains(usuarioId);
  }

  isFollowingColecao(Collection colecao) async {
    List<Collection> seguindo = await getColecoesSeguindo();
    return seguindo
        .map((item) => "${item.nome}${item.dono}")
        .contains("${colecao.nome}${colecao.dono}");
  }
}
