import 'package:flutter/material.dart';
import '../../../models/usuario.dart';

class ProfileHeader extends StatelessWidget {
  final Usuario usuario;
  const ProfileHeader({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
          width: width,
          decoration: BoxDecoration(
              image: usuario.header!= null
                  ? DecorationImage(
                      image: Image.network(
                        usuario.header!,
                        errorBuilder: (context, error, stackTrace) =>
                            const Text("Erro ao carregar a imagem ;-;"),
                      ).image,
                      fit: BoxFit.cover,
                    )
                  : null),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.9],
              colors: [
                Colors.transparent,
                Theme.of(context).scaffoldBackgroundColor
              ],
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  height: height * 0.15,
                  width: height * 0.15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 2,
                        color: Colors.grey[600]!,
                        strokeAlign: BorderSide.strokeAlignOutside),
                    image: DecorationImage(
                      image: Image.network(
                        usuario.avatar ??
                            "https://picsum.photos/400/400",
                        errorBuilder: (context, error, stackTrace) {
                          return const Text("Erro ao localizar a imagem");
                        },
                      ).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: height * 0.01,
                      left: width * 0.05,
                      right: width * 0.05),
                  child: Text(
                    usuario.username ??
                        usuario.uid!,
                    style: const TextStyle(fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
  }
}

