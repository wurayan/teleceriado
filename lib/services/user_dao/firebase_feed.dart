import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teleceriado/services/api_service.dart';
import 'package:teleceriado/services/user_dao/firebase_export.dart';

import '../../models/episodio.dart';
import '../../models/usuario.dart';

class FirebaseFeed {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseUsers _users = FirebaseUsers();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseEpisodios _episodios = FirebaseEpisodios();
  final ApiService _api = ApiService();

  Future<List<Episodio>> getFeed() async {
    List<Episodio> episodios = [];
    
    var res = await db.collection("/comentarios").orderBy("publicado", descending: true).get();
    episodios.addAll(await toList(res));
    return episodios;

  }

  Future<List<Episodio>> toList(QuerySnapshot<Map<String, dynamic>> res) async  {
    List<Episodio> episodios = [];
    for (var doc in res.docs) {
      Map data = doc.data();
      Usuario usuario = await _users.getUserdata(userId: data["usuario"]);
      Episodio episodio = Episodio().copyWith(
        newNumero: int.parse(data["numero"]),
        newSerieId: data["serie"],
        newTemporada: data["temporada"],
      );
      episodio = await _api.getOnlyEpisodio(episodio);
      DocumentSnapshot<Map<String, dynamic>> res = await data["path"].get();
      // db.doc(data["path"]).get();
      Map? ep = res.data();
      episodio.descricao = ep?["descricao"] ?? episodio.descricao;
      episodio.nome = ep?["nome"] ?? episodio.nome;
      episodio.criador = usuario.username ?? usuario.uid!;
      episodios.add(episodio);
    }
    return episodios;
  } 
}