import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/screens/comunidade/comunidade.dart';
import 'package:teleceriado/screens/home/widget/drawer_header.dart';
import 'package:teleceriado/screens/home/widget/drawer_item.dart';
import 'package:teleceriado/screens/profile/profile.dart';
import '../../../models/version.dart';
import '../../../services/auth.dart';

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
            // TextButton(
            //     onPressed: () {
            //       Version version = Version();
            //       version.localVersion = "3.0.0";
            //       version.newVersion = "3.0.1";
            //       version.versionLink = "google.com";
            //       ErrorHandler.versionOutdated(version);
            //     },
            //     child: const Text("ARRIVA CHICO CARLITO"),),
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
