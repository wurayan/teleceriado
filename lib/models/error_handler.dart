import 'package:flutter/material.dart';

class ErrorHandler {
  static GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static void show(String mensagem) {
    if (key.currentContext != null) {
      showDialog(
        context: key.currentContext!,
        builder: (context) => Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Erro",
                  style: TextStyle(fontSize: 18),
                ),
                const Divider(
                  thickness: 0.5,
                  height: 1,
                  color: Colors.grey,
                ),
                Text(
                  mensagem,
                  style: const TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text("Fechar"),
                )
              ],
            ),
          ),
        ),
      );
    }
  }
}
