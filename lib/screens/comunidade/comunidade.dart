import 'package:flutter/material.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/components/loading_frases.dart';
import 'package:teleceriado/screens/comunidade/widgets/seguindo.dart';
import 'package:teleceriado/screens/comunidade/widgets/seguindo_colecoes.dart';
import 'package:teleceriado/screens/comunidade/widgets/top_users.dart';
import 'package:teleceriado/services/user_dao/firebase_comunidade.dart';
import '../../models/usuario.dart';

class Comunidade extends StatefulWidget {
  const Comunidade({super.key});

  @override
  State<Comunidade> createState() => _ComunidadeState();
}

class _ComunidadeState extends State<Comunidade>
    with AutomaticKeepAliveClientMixin {
  final FirebaseComunidade _comunidade = FirebaseComunidade();

  List<Usuario> topUsers = [];
  List<String> seguindo = [];
  List<String> colecoes = [];

  getCollections() async {
    topUsers = await _comunidade.getUsuarios();
    seguindo = await _comunidade.getUsuariosSeguindo();
    colecoes = await _comunidade.getColecoesSeguindo();
    setState(() {});
  }

  @override
  void initState() {
    getCollections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comunidade"),
      ),
      body: topUsers.isEmpty
          ? Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4),
                child: const Loading(),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: LoadingFrases(loading: topUsers.isEmpty)),
            ],
          )
          : CustomScrollView(
              slivers: [
                TopUsers(
                  usuarios: topUsers,
                ),
                Seguindo(
                  seguindo: seguindo,
                ),

              ],
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
