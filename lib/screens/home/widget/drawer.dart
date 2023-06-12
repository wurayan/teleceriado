import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/episodio.dart';
import 'package:teleceriado/screens/home/widget/choose_username.dart';
import 'package:teleceriado/services/user_dao/user_collections.dart';
import 'package:teleceriado/utils/utils.dart';
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
                        Color.fromARGB(255, 255, 160, 0),
                        Color.fromARGB(255, 255, 62, 0)
                      ]),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: height * 0.02,
                    left: width * 0.02,
                    right: width * 0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.01, right: width * 0.01),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => ChooseUsername(),
                            );
                          },
                          child: const Icon(
                            Icons.edit_rounded,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox(width: null, height: null)),
                    Text(
                      Provider.of<Usuario?>(context)!.username
                       ?? Provider.of<Usuario?>(context)!.uid,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                    ),
                  ],
                ),
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
            // TextButton(
            //   onPressed: ()async{
            //     FirebaseCollections col = FirebaseCollections();
            //     Episodio episodio = Episodio();
            //     episodio
            //     Map? map = await col.getEditedEpisodio(

            //     );
            //     print("verificação do link imagem, : $val");
            //   },
            //   child: const Text("validate image"),
            // ),
            TextButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: const Text("SAIR"),
            )
          ],
        ),
      ),
    );
  }
}
