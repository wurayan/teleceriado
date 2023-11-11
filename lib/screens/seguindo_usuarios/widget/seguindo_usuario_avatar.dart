import 'package:flutter/material.dart';
import 'package:teleceriado/components/emoji_generator.dart';
import 'package:teleceriado/models/usuario.dart';
import 'package:teleceriado/screens/usuarios/user_page.dart';

class UsuarioAvatar extends StatelessWidget {
  final Usuario usuario;
  const UsuarioAvatar({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: () {
        if (usuario.uid == null) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserPage(usuarioId: usuario.uid!),
          ),
        );
      },
      child: SizedBox(
        // height: height * 0.0,
        width: width * 0.5,
        child: Column(
          children: [
            Container(
              height: height * 0.2,
              width: width * 0.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2,
                    color: Colors.grey[200]!,
                    strokeAlign: BorderSide.strokeAlignOutside),
              ),
              clipBehavior: Clip.hardEdge,
              child: usuario.avatar != null
                  ? Image.network(
                      usuario.avatar!,
                      fit: BoxFit.cover,
                    )
                  : const Center(
                      child: EmojiGenerator(generate: true),
                    ),
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
