import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:teleceriado/models/error_handler.dart';
import 'package:teleceriado/services/prefs.dart';
import 'package:teleceriado/services/user_dao/firebase_collections.dart';
import '../models/usuario.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Prefs _prefs = Prefs();
  final FirebaseCollections _collection = FirebaseCollections();

Stream<Usuario?> get onAuthStateChanged {
    Stream<Usuario?> res;
    try {
      res = _auth
        .authStateChanges()
        .map((User? user) => _usuarioFromFirebase(user));  
    } catch (e) {
      print("Erro ${e.toString()}\nstack: ${StackTrace.current}");
      throw Exception(e);
    }
    return res;
  }

  Usuario? _usuarioFromFirebase(User? usuario) {
    print(usuario.toString());
    if (usuario != null) {
      Usuario user = Usuario();
      user.uid = usuario.uid;
      // _collection.getUserdata(usuario.uid);
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
      await _prefs.saveUserId(usuario!.uid!);
      _collection.createFavorites();
      return usuario;
    } catch (e) {
      throw Exception(e);
    }
  }

  

  Future signOut() async {
    try {
      _prefs.deleteUsereId();
      return await _auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future signIn(String email, String senha) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: senha);
      User user = result.user!;
      Usuario? usuario = _usuarioFromFirebase(user);
      _prefs.saveUserId(usuario!.uid!);

      return usuario;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Usuario> signInGoogle() async {
    DateTime init = DateTime.now();

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      try {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        DateTime? creationTime = _auth.currentUser?.metadata.creationTime;
        User user = userCredential.user!;
        Usuario? usuario = _usuarioFromFirebase(user);
        _prefs.saveUserId(usuario!.uid!);
        if(creationTime!=null && !creationTime.isBefore(init)) 
        {
          _collection.createFavorites();
          }
        return usuario;
      } on FirebaseAuthException catch(e) {
        if (e.code == "account-exists-with-different-credential")  ErrorHandler.show("Essa conta já existe com outra credencial!");
        if(e.code == "invalid-credential")  ErrorHandler.show("Credenciais inválidas!");
        throw Exception();
      } 
      catch (e) {
        ErrorHandler.show(e.toString());
        throw Exception();
      }
    } else {
      ErrorHandler.show("Erro Desconhecido");
      throw Exception();
    }
  }

  Future cadastro(String email, String senha) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      User user = result.user!;
      Usuario? usuario = _usuarioFromFirebase(user);
      await _prefs.saveUserId(usuario!.uid!);
      _collection.createFavorites();
      return usuario;
    } catch (e) {
      throw Exception(e);
    }
  }
}
