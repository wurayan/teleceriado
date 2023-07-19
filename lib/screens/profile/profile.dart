import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/screens/profile/widget/profile_header.dart';
import 'package:teleceriado/screens/profile/widget/seguidores.dart';

import '../../models/usuario.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(),
            SeguidoresCounter(usuario: Provider.of<Usuario>(context)),
            Padding(
              padding:
                  EdgeInsets.only(top: height * 0.01, bottom: height * 0.015),
              child: Divider(
                height: 2,
                thickness: 1,
                color: Colors.grey[400],
              ),
            ),
            Center(
              child: SizedBox(
                height: height * 0.1,
                width: width * 0.9,
                child: Text(
                  Provider.of<Usuario>(context).bio ??
                      "Que tal contar um pouco mais sobre você?\n\nQuais suas séries Favoritas?",
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.02),
              child: Text(
                "Edições: ${Provider.of<Usuario>(context).editados ?? 0}",
                style: const TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
