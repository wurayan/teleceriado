import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/snackbar.dart';
import '../../models/usuario.dart';
import '../prefs.dart';

class FirebaseUsers {
  final Prefs prefs = Prefs();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Usuario> getUserdata() async {
    String? userUid = await prefs.getUserId();
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
    );
  }

  updateUserdata({String? username, String? avatar}) async {
    if(username==null&&avatar==null) return;

    String? userUid = await prefs.getUserId();
    assert(userUid != null);

    Map<String, dynamic> map = {};

    username != null ? map["username"] = username : null;
    avatar != null ? map["avatar"] = avatar : null;

    var path = db
    .collection("/usuarios")
    .doc("/$userUid");

    path.update(map)
    .onError((error, stackTrace) {
      SnackbarGlobal.show(error.toString());
      throw Exception(error);
    });
  }
}