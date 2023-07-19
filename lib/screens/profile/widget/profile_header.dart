import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/usuario.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      // height: height * 0.25,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0, 0.9],
          colors: [Colors.white10, Theme.of(context).scaffoldBackgroundColor],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: height*0.07,
          ),
          Container(
            height: height * 0.1,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: Colors.grey[600]!,
              ),
              image: DecorationImage(
                image: Image.network(
                  Provider.of<Usuario>(context).avatar ??
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
                top: height * 0.01, left: width * 0.05, right: width * 0.05),
            child: Text(
              Provider.of<Usuario>(context).username ??
                  Provider.of<Usuario>(context).uid!,
              style: const TextStyle(fontSize: 20),
              maxLines: 2,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}