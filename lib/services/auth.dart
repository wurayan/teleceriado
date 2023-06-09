import 'package:firebase_auth/firebase_auth.dart';
import 'package:teleceriado/services/prefs.dart';
import 'package:teleceriado/services/user_dao/user_collections.dart';
import '../models/usuario.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Prefs _prefs = Prefs();
  final FirebaseCollections _collection = FirebaseCollections();

  Usuario? _usuarioFromFirebase(User? usuario) {
    if (usuario!= null) {
      Usuario user = Usuario(usuario.uid);
      // _prefs.saveUserId(user.uid);
      return user;
    } else {
      return null;
    }
  }

  Future signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      Usuario? usuario = _usuarioFromFirebase(user);
      await _prefs.saveUserId(usuario!.uid);
      _collection.createFavorites();
      return usuario;
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<Usuario?> get onAuthStateChanged{
    return _auth.authStateChanges().map((User? user) => _usuarioFromFirebase(user));
  }

  Future signOut() async {
    try {
      _prefs.deleteUsereId();
      return await _auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future signIn (String email, String senha) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: senha);
      User user = result.user!;
      Usuario? usuario = _usuarioFromFirebase(user);
      _prefs.saveUserId(usuario!.uid);
      
      return usuario;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future cadastro(String email, String senha) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      User user = result.user!;
      Usuario? usuario = _usuarioFromFirebase(user);
      await _prefs.saveUserId(usuario!.uid);
      _collection.createFavorites();
      return usuario;
    } catch (e) {
      throw Exception(e);
    }
  } 
}
