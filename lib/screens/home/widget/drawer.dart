import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/usuario.dart';
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
            Container(
              width: double.infinity,
              height: height * 0.17,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 46, 80, 143),
                        Color.fromARGB(255, 7, 37, 119)
                      ]),
                 borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(20)),
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width*0.2,
                    height: width*0.2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: Colors.grey[300]!
                      )
                    ),
                    child: Provider.of<Usuario>(context).avatar!=null
                    ? Image.network(
                      Provider.of<Usuario>(context).avatar!,
                      fit: BoxFit.cover,
                    )
                    : const Center(
                      child: Text("Sem Imagem",
                      textAlign: TextAlign.center,),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height*0.01),
                    child: Text(
                      Provider.of<Usuario>(context).username ?? "Carregando...",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.01),
              child: InkWell(
                onTap: () {
                  //cONECTAR A TELA DE COMUNIDADE
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
                "Versão 2.0.2",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
              ),
            )
          ],
        ),
      ),
    );
  }
}
