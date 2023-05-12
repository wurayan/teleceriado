import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../models/serie_model.dart';
import '../../../utils/utils.dart';

class SerieHeader extends StatelessWidget {
  final Serie serie;
  const SerieHeader({super.key, required this.serie});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        serie.imagens == null || serie.imagens!.isEmpty
            ? const Center(
                child: Text(
                  'Imagem não encontrada ;-;',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                width: width,
                height: height * 0.2,
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  serie.imagens![0],
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.01, left: width * 0.02),
          child: Text(
            serie.nome,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(right: width * 0.01),
              child: Text(situacao.containsKey(serie.status)
                  ? 'Situação: ${situacao[serie.status]}'
                  : 'Situação: ${serie.status}'),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: SizedBox(
            height: height * 0.1,
            width: width,
            child: Text(
              serie.descricao == null ? 'Sem descrição' : serie.descricao!,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.01),
          child: const Divider(
            color: Colors.black54,
            thickness: 1,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    // left: width * 0.02,
                    bottom: height * 0.01),
                child: const Text(
                  'Episódios',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: height * 0.01),
              child: const Text('Detalhes', style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ],
    );
  }
}
