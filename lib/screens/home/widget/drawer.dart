import 'package:flutter/material.dart';
import 'package:teleceriado/screens/comunidade/comunidade.dart';
import 'package:teleceriado/screens/home/widget/drawer_header.dart';
import 'package:teleceriado/services/user_dao/comunidade_dao.dart';
import 'package:teleceriado/services/user_dao/firebase_collections.dart';
import 'package:teleceriado/utils/color_checker.dart';
import '../../../models/episodio.dart';
import '../../../services/api_service.dart';
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
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Comunidade(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: height * 0.06,
                  // color: Colors.grey[700],
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.02, right: width * 0.04),
                        child: const Icon(Icons.view_carousel_rounded),
                      ),
                      const Text(
                        "Comunidade",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
              },
              child: Text("ARRIVA CHICO CARLITO")
            ),
            const Expanded(child: SizedBox(width: null, height: null)),
            TextButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: const Text("SAIR"),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.01),
              child: const Text(
                "Versão 2.0.3",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
              ),
            )
          ],
        ),
      ),
    );
  }
}
