import 'package:flutter/material.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/models/collection.dart';
import 'package:teleceriado/screens/collections/collection_details.dart';

class UserCollectionsList extends StatelessWidget {
  final List<Collection> colecoes;
  const UserCollectionsList({super.key, required this.colecoes});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(childCount: colecoes.length,
          (context, index) {
        Collection colecao = colecoes[index];
        return _Collections(colecao: colecao);
      }),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 1.3),
    );
  }
}

class _Collections extends StatelessWidget {
  final Collection colecao;
  const _Collections({required this.colecao});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
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
                  image: Image.network(
                    colecao.imagem!,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text("Deu ruim");
                    },
                  ).image,
                  colorFilter: const ColorFilter.mode(
                      Colors.black26, BlendMode.darken),
                  fit: BoxFit.cover
                  )
              : null,
          color: colecao.imagem == null ? Colors.blueGrey[600] : Colors.transparent,
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
  }
}

