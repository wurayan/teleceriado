import 'package:flutter/material.dart';
import 'package:teleceriado/screens/usuarios/widgets/follow_button.dart';
import 'package:teleceriado/screens/usuarios/widgets/user_header.dart';

import '../../../models/usuario.dart';

class UserScreen extends StatelessWidget {
  final Usuario usuario;
  const UserScreen({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserHeader(usuario: usuario),
          Padding(
            padding: EdgeInsets.only(left: width * 0.03),
            child: Text(
              "seguidores: ${usuario.seguidoresQtde}",
              style: const TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w300, letterSpacing: 1),
              ),
          ),
          SizedBox(
            width: width * 0.95,
            height: height * 0.15,
            child: Center(
              child: Text(
                usuario.bio ??
                    "Este usuário não tem nada a falar sobre si mesmo.",
                // "Lorem ipsum sit dolo amec viat seccum sacharum omnis spiritus immundus apendus eccio fira lat etum lattes ergo visavi et corbumculum espera ati fio lat enum argo mit sit mihi lux non deraco sit mihi lux va de retro",
                style: const TextStyle(fontSize: 18),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 6,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.02, right: width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Contribuições: não implementado",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                BotaoSeguindo(usuario: usuario)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
