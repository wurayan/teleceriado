import 'package:flutter/material.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/screens/users/widgets/user_collections.dart';
import 'package:teleceriado/screens/users/widgets/user_comentarios.dart';
import 'package:teleceriado/screens/users/widgets/user_details.dart';
import 'package:teleceriado/screens/users/widgets/user_header.dart';
import 'package:teleceriado/services/api_service.dart';

import '../../models/collection.dart';
import '../../models/serie.dart';
import '../../models/usuario.dart';
import '../../services/user_dao/firebase_collections.dart';

class UserPage extends StatefulWidget {
  final Usuario usuario;
  const UserPage({super.key, required this.usuario});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final FirebaseCollections _collections = FirebaseCollections();

  List<Collection> colecoes = [];
  List<Serie> series = [];
  final List<Widget> opcoes = [];
  int option = 0;

  changeOption() {
    if (option == 0) {
      option = 1;
    } else {
      option = 0;
    }
    setState(() {});
  }

  getCollections() async {
    List<String> res =
        await _collections.getAllCollections(user: widget.usuario.uid);
    for (String colecaoNome in res) {
      colecoes.add(await _collections.getCollectionInfo(colecaoNome,
          userId: widget.usuario.uid));
    }
    series = await _collections.getAllEditedSeries(userId: widget.usuario.uid);
    opcoes.addAll([
      UserCollectionsList(colecoes: colecoes),
      UserComentarios(series: series)
    ]);
    setState(() {});
  }

  @override
  void initState() {
    getCollections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: UserHeader(usuario: widget.usuario),
            ),
            UserDetails(usuario: widget.usuario),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height * 0.05,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        if (option != 0) {
                          setState(() {
                            option = 0;
                          });
                        }
                      },
                      child: Text(
                        "Coleções: ",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: option == 0 ? Colors.white : Colors.white54),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (option != 1) {
                          setState(() {
                            option = 1;
                          });
                        }
                      },
                      child: Text(
                        "Comentários: ",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: option == 1 ? Colors.white : Colors.white54),
                      ),
                    )
                  ],
                ),
              ),
            ),
            series.isEmpty && colecoes.isEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
                    child: const Loading(),
                  ))
                : opcoes[option]
          ],
        ),
      ),
    );
  }
}
