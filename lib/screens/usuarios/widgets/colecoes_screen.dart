import 'package:flutter/material.dart';
import 'package:teleceriado/screens/collections/collection_details.dart';

import '../../../models/collection.dart';

class ColecoesScreen extends StatelessWidget {
  final List<Collection> colecoes;
  const ColecoesScreen({super.key, required this.colecoes});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1.3),
          itemCount: colecoes.length,
          itemBuilder: (context, index) {
            Collection colecao = colecoes[index];
            return _ColecaoItem(
              colecao: colecao,
            );
          },
        )
      ],
    );
  }
}

class _ColecaoItem extends StatelessWidget {
  final Collection colecao;
  const _ColecaoItem({required this.colecao});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CollectionDetails(
            colecao: colecao,
          ),
        ));
      },
      child: Container(
        height: height * 0.075,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.network(
                  colecao.imagem!,
                ).image,
                fit: BoxFit.cover,
                colorFilter:
                    const ColorFilter.mode(Colors.black38, BlendMode.darken),
                alignment: Alignment.topCenter),
            borderRadius: BorderRadius.circular(15)),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.only(left: width * 0.05, bottom: height * 0.01),
            child: Text(
              colecao.nome!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
