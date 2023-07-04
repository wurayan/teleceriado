import 'package:flutter/material.dart';
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
        children: [
          UserHeader(usuario: usuario),
          SizedBox(
            width: width*0.95,
            height: height*0.15,
            child: Text(
              usuario.bio ?? "Este usuário não tem nada a falar sobre si mesmo.",
              // "Lorem ipsum sit dolo amec viat seccum sacharum omnis spiritus immundus apendus eccio fira lat etum lattes ergo visavi et corbumculum espera ati fio lat enum argo mit sit mihi lux non deraco sit mihi lux va de retro",
              style: const TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 6,
            ),
          )
        ],
      ),
    );
  }
}