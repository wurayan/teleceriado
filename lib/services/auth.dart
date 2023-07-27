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
      ErrorHandler.showSimple(e.toString());
      throw Exception(e);
    }
    return res;
  }

  Usuario? _usuarioFromFirebase(User? usuario) {
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
      _collection.firstTime();
      return usuario;
    } on FirebaseAuthException catch (e) {
      ErrorHandler.authError(e);
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
    } on FirebaseAuthException catch (e) {
      ErrorHandler.authError(e);
    } catch (e) {
      ErrorHandler.showSimple(
          "Não foi possível fazer Login, tente novamente mais tarde.\nSe o erro persistir contate o Suporte.");
    }
  }

  Future<Usuario> signInGoogle() async {
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
        User user = userCredential.user!;
        Usuario? usuario = _usuarioFromFirebase(user);
        _prefs.saveUserId(usuario!.uid!);
        DateTime? creation = _auth.currentUser?.metadata.creationTime;
        DateTime? lastSignin = _auth.currentUser?.metadata.lastSignInTime;
        // print(creation);
        // print(lastSignin);
        // print(!(creation!.difference(lastSignin!) > const Duration(minutes: 1)));
        if (creation!=null && !(creation.difference(lastSignin!) > const Duration(minutes: 1))) {
          await _collection.firstTime();
        }
        usuario.firstTime = true;
        return usuario;
      } on FirebaseAuthException catch (e) {
        ErrorHandler.authError(e);
        throw Exception();
      } catch (e) {
        ErrorHandler.showSimple(e.toString());
        throw Exception();
      }
    } else {
      ErrorHandler.showSimple(
          "Não foi possível fazer login usando Google, tente novamente mais tarde.\nSe o erro persistir, entre em contato com o Suporte.");
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
      _collection.firstTime();
      usuario.firstTime = true;
      return usuario;
    } on FirebaseAuthException catch (e) {
      ErrorHandler.authError(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
