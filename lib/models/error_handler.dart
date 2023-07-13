import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static void show(String title, String mensagem) {
    if (key.currentContext != null) {
      showDialog(
        context: key.currentContext!,
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          final double width = MediaQuery.of(context).size.width;
          return Dialog(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              // height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: height * 0.02, left: width * 0.03),
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 20, letterSpacing: 1),
                    ),
                  ),
                  const Divider(
                    thickness: 0.5,
                    height: 2,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.01),
                    child: Text(mensagem,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: width * 0.02),
                        child: const Text(
                          "Fechar",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }

  static void showSimple(String mensagem) {
    if (key.currentContext != null) {
      showDialog(
        context: key.currentContext!,
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          final double width = MediaQuery.of(context).size.width;
          return Dialog(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              // height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(width * 0.02, height * 0.02,
                        width * 0.02, height * 0.01),
                    child: Text(mensagem,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: width * 0.02),
                        child: const Text(
                          "Fechar",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }

  static void authError(FirebaseAuthException e) async {
    switch (e.code) {
      case "email-already-exists":
        return showSimple(
            "Parece que já existe uma conta cadastrada com este E-mail.");
      case "email-already-in-use":
        return showSimple(
            "Parece que já existe uma conta cadastrada com este E-mail.");
      case "invalid-email":
        return showSimple("Email inválido!");
      case "wrong-password":
        return showSimple("Senha Incorreta!");
      case "invalid-password":
        return showSimple("A senha deve conter no mínimo seis caracteres.");
      case "user-not-found":
        return showSimple(
            "Não encontramos nenhum usuário cadastrado neste E-mail.");
      case "account-exists-with-different-credential":
        FirebaseAuth auth = FirebaseAuth.instance;
        List<String> list = await auth.fetchSignInMethodsForEmail(e.email!);
        return showSimple("Parece que você já tem uma conta usando ${list.first}.");
      default:
        return showSimple(
            "Não foi possível fazer Login, tente novamente mais tarde.");
    }
  }
}
