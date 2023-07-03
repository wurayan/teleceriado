import 'package:flutter/material.dart';

import '../../../models/collection.dart';

class ColecoesScreen extends StatelessWidget {
  final List<Collection> colecoes;
  const ColecoesScreen({super.key, required this.colecoes});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if(details.primaryVelocity! > 0){
          print("swiped direira para esquerda");
        } else if (details.primaryVelocity! < 0) {
          print("swiped esquerda para direita");
        }
      },
      child: Container
      (),
    );
  }
}