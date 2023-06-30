import 'package:flutter/material.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/models/collection.dart';
import 'package:teleceriado/screens/collections/collection_details.dart';
import 'package:teleceriado/services/user_dao/firebase_collections.dart';
import '../../../models/usuario.dart';

class UserCollectionsList extends StatefulWidget {
  final Usuario usuario;
  const UserCollectionsList({super.key, required this.usuario});

  @override
  State<UserCollectionsList> createState() => _UserCollectionsListState();
}

class _UserCollectionsListState extends State<UserCollectionsList>
    with AutomaticKeepAliveClientMixin {
  final FirebaseCollections _collections = FirebaseCollections();
  List<Collection> colecoes = [];

  getCollections() async {
    List<String> res =
        await _collections.getAllCollections(user: widget.usuario.uid);
    for (String colecaoNome in res) {
      colecoes.add(await _collections.getCollectionInfo(colecaoNome, userId: widget.usuario.uid));
    }
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
    return colecoes.isEmpty
        ? SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: const Loading(),
                )
              ],
            ),
          )
        : _Collections(
            colecoes: colecoes,
          );
  }

  @override
  bool get wantKeepAlive => true;
}

class _Collections extends StatelessWidget {
  final List colecoes;
  const _Collections({required this.colecoes});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(childCount: colecoes.length,
          (context, index) {
        Collection colecao = colecoes[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CollectionDetails(collectionId: colecao.nome!),
              ),
            );
          },
          child: Container(
            width: width * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: colecao.imagem != null
                  ? DecorationImage(
                      image: NetworkImage(
                        colecao.imagem!,
                      ),
                      colorFilter: const ColorFilter.mode(
                          Colors.black12, BlendMode.darken),
                      fit: BoxFit.cover)
                  : null,
            ),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding:
                  EdgeInsets.only(left: width * 0.02, bottom: height * 0.01),
              child: Text(colecao.nome ?? "Erro",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5),
                  overflow: TextOverflow.clip),
            ),
          ),
        );
      }),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 1.3),
    );
  }
}
