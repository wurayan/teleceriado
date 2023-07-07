// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:teleceriado/components/loading.dart';
// import 'package:teleceriado/services/user_dao/firebase_export.dart';

// import '../../../models/collection.dart';
// import '../../../models/error_handler.dart';

// class SeguindoColecoes extends StatefulWidget {
//   final List<String> colecoes;
//   const SeguindoColecoes(
//       {super.key, required this.colecoes});

//   @override
//   State<SeguindoColecoes> createState() => _SEguindoColecoesState();
// }

// class _SEguindoColecoesState extends State<SeguindoColecoes> {
//   final FirebaseCollections _collections = FirebaseCollections();
//   List<Collection> colecoesList = [];
//   bool loading = false;

//   getColecoes(List<String> colecoes, String userId) async {
//     int qtde = colecoes.length < 20 ? colecoes.length : 20;
//     for (var i = 0; i < qtde; i++) {
//       colecoesList.add(
//         await _collections.getCollectionInfo(colecoes[i], userId: userId),
//       );
//     }
//     loading = false;
//     setState(() {});
//   }

//   @override
//   void initState() {
//     getColecoes(widget.colecoes, widget.userId);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double height = MediaQuery.of(context).size.height;
//     final double width = MediaQuery.of(context).size.width;
//     return SliverToBoxAdapter(
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "Coleções que segue:",
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                     letterSpacing: 1),
//               ),
//               TextButton(
//                 onPressed: () {
//                   ErrorHandler.show("Nada aqui ainda!");
//                 },
//                 child: const Text(
//                   "MAIS",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               )
//             ],
//           ),
//           loading
//               ? const Loading()
//               : colecoesList.isEmpty
//                   ? const Center(
//                       child: Text(
//                         "Que lugar Vazio...\nQue tal seguir uma Coleção?",
//                         textAlign: TextAlign.center,
//                       ),
//                     )
//                   : SizedBox(
//                       height: height * 0.02,
//                       child: ListView.builder(
//                         itemCount: colecoesList.length,
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (context, index) {
//                           return ColecaoItem(colecao: colecoesList[index]);
//                         },
//                       ),
//                     )
//         ],
//       ),
//     );
//   }
// }

// class ColecaoItem extends StatelessWidget {
//   final Collection colecao;
//   const ColecaoItem({super.key, required this.colecao});

//   @override
//   Widget build(BuildContext context) {
//     final double height = MediaQuery.of(context).size.height;
//     final double width = MediaQuery.of(context).size.width;
//     return Container(
//       height: height * 0.2,
//       width: width * 0.3,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: Image.network(
//             colecao.imagem!,
//             errorBuilder: (context, error, stackTrace) {
//               return const Text("Não foi possível carregar a imagem");
//             },
//           ).image,
//           fit: BoxFit.cover,
//           colorFilter: const ColorFilter.mode(Colors.black38, BlendMode.darken),
//         ),
//       ),
//       alignment: Alignment.bottomLeft,
//       child: Text(
//         colecao.nome!,
//       ),
//     );
//   }
// }
