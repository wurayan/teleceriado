import 'package:flutter/material.dart';
import 'package:teleceriado/components/emoji_generator.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/components/loading_frases.dart';
import 'package:teleceriado/screens/usuarios/user_page.dart';
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

  List<Usuario> usuarios = [];

  getCollections() async {
    usuarios = await _comunidade.getUsuarios();
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
      body: CustomScrollView(
        slivers: [
          usuarios.isEmpty
              ? SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.4),
                        child: const Loading(),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: LoadingFrases(loading: usuarios.isEmpty)),
                    ],
                  ),
                )
              : _UserList(
                  usuarios: usuarios,
                ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _UserList extends StatelessWidget {
  final List<Usuario>? usuarios;
  const _UserList({required this.usuarios});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.02, left: width * 0.02),
            child: const Text(
              "Top Contribuintes",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1),
            ),
          ),
          usuarios == null || usuarios!.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: height * 0.05),
                  child: const Center(
                    child: Text(
                      "(◞‸◟) É triste estar sozinho né...",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: height * 0.01),
                  child: SizedBox(
                    height: height * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: usuarios!.length,
                      itemBuilder: (context, index) {
                        return _UsuarioItem(
                          usuario: usuarios![index],
                        );
                      },
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

class _UsuarioItem extends StatelessWidget {
  final Usuario usuario;
  const _UsuarioItem({required this.usuario});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => UserPage(usuario: usuario,)));
      },
      child: SizedBox(
        height: height * 0.15,
        width: width * 0.27,
        child: Column(
          children: [
            Container(
              height: height * 0.1,
              width: width * 0.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.grey[200]!),
              ),
              clipBehavior: Clip.hardEdge,
              child: usuario.avatar != null
                  ? Image.network(
                      usuario.avatar!,
                      fit: BoxFit.cover,
                    )
                  : const Center(child: EmojiGenerator(generate: true)),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.005),
              child: Text(
                usuario.username ?? usuario.uid!,
                overflow: TextOverflow.clip,
              ),
            )
          ],
        ),
      ),
    );
  }
}
