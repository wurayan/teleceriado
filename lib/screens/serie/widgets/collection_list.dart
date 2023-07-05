import 'package:flutter/material.dart';
import 'package:teleceriado/models/error_handler.dart';
import 'package:teleceriado/screens/collections/create_collection.dart';

import '../../../models/collection.dart';
import '../../../models/serie.dart';
import '../../../models/snackbar.dart';
import '../../../services/user_dao/firebase_collections.dart';

class CollectionList extends StatelessWidget {
  final Serie serie;
  final List<Collection> collectionList;
  CollectionList(
      {super.key, required this.collectionList, required this.serie});

  final FirebaseCollections _collections = FirebaseCollections();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: const Color.fromARGB(200, 89, 94, 112),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: SizedBox(
        height: height * 0.5,
        width: width * 0.7,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.02),
          child: ListView.builder(
            itemCount: collectionList.length + 1,
            itemBuilder: (context, index) {
              if (index < collectionList.length) {
                Collection colecao = collectionList[index];
                return InkWell(
                  onTap: () {
                    _collections.saveInCollection(colecao.nome!, serie).then(
                      (value) {
                        Navigator.pop(context);
                        SnackbarGlobal.show("Série salva em ${colecao.nome!}!");
                      },
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.075,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Image.network(
                              colecao.imagem!,
                              errorBuilder: (context, error, stackTrace) {
                                ErrorHandler.show(
                                    "${error.toString()}\n${stackTrace.toString()}");
                                return const Text("Erro ao carregar a imagem");
                              },
                            ).image,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.hardEdge,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [
                                    0,
                                    0.4,
                                    0.6
                                  ],
                                  colors: [
                                    Colors.transparent,
                                    Color.fromARGB(200, 33, 33, 33),
                                    Color.fromARGB(223, 48, 48, 48),
                                  ]),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              colecao.nome!,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateCollection(
                          serie: serie,
                        ),
                      ),
                    ).then((value) =>
                        value == true ? Navigator.pop(context) : null);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      alignment: Alignment.center,
                      height: height * 0.05,
                      child: RichText(
                        text: const TextSpan(
                          text: "Criar Coleção  ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.add_rounded,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
