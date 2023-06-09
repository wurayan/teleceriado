import 'dart:async';
import 'package:flutter/material.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/screens/collections/collection_details.dart';
import 'package:teleceriado/screens/serie/serie_details.dart';
import 'package:teleceriado/services/user_dao/user_collections.dart';
import 'package:teleceriado/utils/utils.dart';

import '../models/serie.dart';
import '../services/api_service.dart';

class UserFeed extends StatefulWidget {
  const UserFeed({super.key});

  @override
  State<UserFeed> createState() => _UserFeedState();
}

class _UserFeedState extends State<UserFeed>
    with AutomaticKeepAliveClientMixin {
  final FirebaseCollections _collections = FirebaseCollections();
  List<Map<String, List<Serie>>> colecoes = [];
  String loadingFrase = getLoadingFrase();
  Timer? timer;


//TODO TALVEZ TENHAMOS QUE USAR O OUTRO METODO DE CONSTRUIR LIST COM FUTURE, PARA ASSIM A LISTA SER ATUALIZADA CONFORME É ALTERADA
  getCollections(){
    _collections.getAllCollections().then((collectionList) async {
      for (String collection in collectionList) {
        List<Serie> series = await _collections.getCollectionSeries(collection);
        colecoes.add({collection: series});
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    getCollections();
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        loadingFrase = getLoadingFrase();
      });
    });
    super.initState();
  }

  cancelTimer(){
    if (timer!=null) {
      timer!.cancel();
    }
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // _collections.updateUi(
    //   getCollections
    // );
    return CustomScrollView(
      slivers: [
        colecoes.isEmpty
            ? SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.4),
                      child: const Loading(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        loadingFrase,
                        style: const TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              )
            : _CollectionList(
                collectionList: colecoes,
              ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _CollectionList extends StatelessWidget {
  final List collectionList;
  const _CollectionList({required this.collectionList});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SliverList.builder(
      itemCount: collectionList.length,
      itemBuilder: (context, index) {
        Map<String, List<Serie>> colecao = collectionList[index];
        String? titulo;
        List<Serie>? series;
        colecao.forEach((key, value) {
          titulo = key;
          series = value;
        });
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.02,
                  left: width * 0.02,
                  bottom: height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(titulo!,
                      style: const TextStyle(
                        fontSize: 18,
                      )),
                  Padding(
                    padding: EdgeInsets.only(right: width * 0.05),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CollectionDetails(collectionId: titulo!),
                          ),
                        );
                      },
                      child: const Text(
                        "MAIS",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
            series == null || series!.isEmpty
                ? Padding(
                  padding: EdgeInsets.only(top: height*0.05),
                  child: const Center(
                      child: Text(
                        "(◞‸◟) Não encontramos nenhuma série...",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                )
                : SizedBox(
                    height: height * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: series?.length ?? 0,
                      itemBuilder: (context, index) {
                        return series != null || series!.isNotEmpty
                            ? _CollectionItem(serie: series![index])
                            : const Center(
                                child: Text(
                                    "(◞‸◟) Não encontramos nenhuma série..."),
                              );
                      },
                    ),
                  )
          ],
        );
      },
    );
  }
}

class _CollectionItem extends StatelessWidget {
  final Serie serie;
  _CollectionItem({super.key, required this.serie});
  final ApiService _api = ApiService();
  @override
  Widget build(BuildContext context) {
    double width = 150;
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.blueGrey.shade700)),
        child: InkWell(
          onTap: () {
            _api.getSerie(serie.id!, 1).then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowDetails(serie: value),
                ),
              );
            });
          },
          child: Image.network(
            _api.getSeriePoster(serie.poster!),
            fit: BoxFit.cover,
            width: width * 0.65,
            height: width,
          ),
        ),
      ),
    );
  }
}
