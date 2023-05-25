import 'package:firebase_auth/firebase_auth.dart';
import '../models/usuario.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Usuario? _usuarioFromFirebase(User? usuario){
    if (usuario!= null) {
      return Usuario(usuario.uid);
    } else {
      return null;
    }
  }

  Future signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _usuarioFromFirebase(user);
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<Usuario?> get onAuthStateChanged{
    return _auth.authStateChanges().map((User? user) => _usuarioFromFirebase(user));
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
