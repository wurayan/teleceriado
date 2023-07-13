import 'package:flutter/material.dart';
import 'package:teleceriado/screens/collections/collection_details.dart';

import '../../../models/collection.dart';

class ColecaoItem extends StatelessWidget {
  final Collection colecao;
  const ColecaoItem({super.key, required this.colecao});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CollectionDetails(colecao: colecao),
            ),
          );
        },
        child: Container(
          width: width * 0.45,
          // height: height * 0.17,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: Image.network(
                colecao.imagem!,
                errorBuilder: (context, error, stackTrace) =>
                    const Text("Erro ao carregar a imagem"),
              ).image,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              colorFilter:
                  const ColorFilter.mode(Colors.black38, BlendMode.darken),
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding:
                  EdgeInsets.only(bottom: height * 0.01, left: width * 0.01),
              child: Text(
                colecao.nome!,
                style: const TextStyle(
                    // fontSize: 16,
                    fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
