import 'package:flutter/material.dart';

class LinkInvalido extends StatelessWidget {
  const LinkInvalido({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Column(
        children: [
          const Text("Link Inválido!"),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("VOLTAR"),
          )
        ],
      ),
    );
  }
}
