import 'package:firebase_auth/firebase_auth.dart';
import 'package:pixel_snap/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/screens/comunidade/comunidade.dart';
import 'package:teleceriado/screens/home/widget/drawer_header.dart';
import 'package:teleceriado/screens/home/widget/drawer_item.dart';
import 'package:teleceriado/screens/profile/profile.dart';
import '../../../models/serie.dart';
import '../../../models/usuario.dart';
import '../../../models/version.dart';
import '../../../services/api_service.dart';
import '../../../services/auth.dart';
import '../../../services/user_dao/firebase_user.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      width: width * 0.6,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const DrawerHeaderInfo(),
            Padding(
              padding: EdgeInsets.only(top: height * 0.01),
              child: DrawerItem(
                navigate: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Comunidade(),
                    ),
                  );
                },
                icon: const Icon(Icons.view_carousel_rounded),
                title: "Comunidade",
              ),
            ),
            DrawerItem(
                navigate: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
                icon: const Icon(Icons.account_circle),
                title: "Perfil"),
            TextButton(
                onPressed: () async {
                  final FirebaseUsers users = FirebaseUsers();
                  Usuario usuario = await users.getUserdata();
                  final ApiService api = ApiService();
                  Usuario provider = Provider.of<Usuario>(context, listen: false);
                  provider.uid = usuario.uid;
                  provider.username = usuario.username;
                  provider.avatar = usuario.avatar;
                  provider.bio = usuario.bio;
                  provider.assistindoAgora = usuario.assistindoAgora;
                  provider.seguidores = usuario.seguidores;
                  provider.editados = usuario.editados;
                  provider.seguidoresQtde = usuario.seguidoresQtde;
                  provider.serieFavorita = usuario.serieFavorita;
                  if (provider.serieFavorita != null ||
                      provider.assistindoAgora != null) {
                    int id =
                        provider.assistindoAgora ?? provider.serieFavorita!;
                    Serie serie = await api.getSerie(id, 1);
                    if (serie.backdrop == null || serie.backdrop!.isEmpty)
                      return;
                    provider.header = api.getSeriePoster(serie.backdrop!);
                  }
                },
                child: const Text("I SEE DEAD POEOLPE")),
            const Expanded(child: SizedBox(width: null, height: null)),
            TextButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: const Text("SAIR"),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.01),
              child: Text(
                Provider.of<Version>(context).localVersion ?? "Carregando",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
              ),
            )
          ],
        ),
      ),
    );
  }
}
