import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/screens/profile/widget/about_you.dart';
import 'package:teleceriado/screens/profile/widget/profile_comentarios.dart';
import 'package:teleceriado/screens/profile/widget/profile_header.dart';
import 'package:teleceriado/screens/profile/widget/seguidores.dart';

import '../../components/custom_appbar.dart';
import '../../models/usuario.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ProfileHeader(),
                      SeguidoresCounter(usuario: Provider.of<Usuario>(context)),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01, bottom: height * 0.015),
                        child: Divider(
                          height: 2,
                          thickness: 1,
                          color: Colors.grey[400],
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          height: height * 0.15,
                          width: width * 0.9,
                          child: Text(
                            Provider.of<Usuario>(context).bio ??
                                "Que tal contar um pouco mais sobre você e as séries que gosta de ver?",
                            style: const TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                      AboutYou(
                        usuario: Provider.of<Usuario>(context),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            width * 0.01, height * 0.01, width * 0.05, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Seus Comentários:",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "${Provider.of<Usuario>(context).editados ?? 0}",
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: ProfileComentarios(
                      usuario: Provider.of<Usuario>(context),
                    ),
                  ),
                )
              ],
            ),
            const CustomAppbar()
          ],
        ),
      ),
    );
  }
}
