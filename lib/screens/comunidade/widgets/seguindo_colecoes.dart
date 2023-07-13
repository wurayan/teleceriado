import 'package:flutter/material.dart';
import 'package:teleceriado/models/error_handler.dart';

import '../../../models/collection.dart';
import 'colecao_item.dart';

class SeguindoColecoes extends StatelessWidget {
  final List<Collection> colecoes;
  const SeguindoColecoes({super.key, required this.colecoes});

  int length() {
    return colecoes.length < 20 ? colecoes.length : 20;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.02),
                child: const Text(
                  "Coleções que segue:",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1),
                ),
              ),
              TextButton(
                onPressed: () {
                  ErrorHandler.show("ble","Ainda não faz nada");
                },
                child: const Text(
                  "MAIS",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          colecoes.isEmpty
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: const Text(
                      "Parece que você não está seguindo nenhuma coleção.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : SizedBox(
                  height: height * 0.17,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: length(),
                    itemBuilder: (context, index) =>
                        ColecaoItem(colecao: colecoes[index]),
                  ),
                )
        ],
      ),
    );
  }
}
