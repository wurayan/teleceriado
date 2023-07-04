import 'package:flutter/material.dart';

import '../../../models/collection.dart';

class ColecoesScreen extends StatelessWidget {
  final List<Collection> colecoes;
  const ColecoesScreen({super.key, required this.colecoes});

  @override
  Widget build(BuildContext context) {
    return Container(); 
    // GestureDetector(
    //   onHorizontalDragEnd: (details) {
    //     if(details.primaryVelocity! > 0){
    //       swipe(true);
    //     } else if (details.primaryVelocity! < 0) {
    //       swipe(false);
    //     }
    //   },
    //   child: Container
    //   (),
    // );
  }
}