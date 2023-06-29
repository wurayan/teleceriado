import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/usuario.dart';

class ComunidadeCollections {
  FirebaseFirestore db = FirebaseFirestore.instance;

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
}
