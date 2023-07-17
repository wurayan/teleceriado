import 'package:flutter/material.dart';

import '../../../components/emoji_generator.dart';
import '../../../models/usuario.dart';
import '../../usuarios/user_page.dart';

class UsuarioItem extends StatelessWidget {
  final Usuario usuario;
  const UsuarioItem({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => UserPage(usuario: usuario,)));
      },
      child: SizedBox(
        height: height * 0.15,
        width: width * 0.27,
        child: Column(
          children: [
            Container(
              height: height * 0.1,
              width: width * 0.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.grey[200]!),
              ),
              clipBehavior: Clip.hardEdge,
              child: usuario.avatar != null
                  ? Image.network(
                      usuario.avatar!,
                      fit: BoxFit.cover,
                    )
                  : const Center(child: EmojiGenerator(generate: true)),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.005),
              child: Text(
                usuario.username ?? usuario.uid!,
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
            )
          ],
        ),
      ),
    );
  }
}
