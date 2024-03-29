import 'package:flutter/material.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/components/loading_frases.dart';
import 'package:teleceriado/screens/collections/collection_details.dart';
import 'package:teleceriado/screens/collections/widget/new_collection.dart';
import 'package:teleceriado/screens/serie/serie_page.dart';
import 'package:teleceriado/services/user_dao/firebase_collections.dart';
import '../../models/collection.dart';
import '../../models/serie.dart';
import '../../services/api_service.dart';

class CollectionsFeed extends StatefulWidget {
  const CollectionsFeed({super.key});

  @override
  State<CollectionsFeed> createState() => _CollectionsFeedState();
}

class _CollectionsFeedState extends State<CollectionsFeed>
    with AutomaticKeepAliveClientMixin {
  final FirebaseCollections _collections = FirebaseCollections();
  List<Collection>? colecoes;

  getCollections() async {
    colecoes = await _collections.getAllCollections();
    setState(() {});
  }

  @override
  void initState() {
    getCollections();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas Coleções"),
        actions: const [NewCollection()],
      ),
      body: CustomScrollView(
        slivers: [
          colecoes == null
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
                          child: LoadingFrases(loading: colecoes == null))
                    ],
                  ),
                )
              : colecoes!.isNotEmpty
                  ? _CollectionList(
                      collectionList: colecoes!,
                    )
                  : const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 200),
                        child: Text("Algo deu errado"),
                      ),
                    ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _CollectionList extends StatelessWidget {
  final List<Collection> collectionList;
  const _CollectionList({required this.collectionList});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SliverList.builder(
      itemCount: collectionList.length,
      itemBuilder: (context, index) {
        Collection colecao = collectionList[index];
        List<Serie> series = colecao.series ?? [];
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
                  Text(colecao.nome!,
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
                                CollectionDetails(colecao: colecao),
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
            series.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: height * 0.05),
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
                      itemCount: series.length,
                      itemBuilder: (context, index) {
                        return _CollectionItem(serie: series[index]);
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
  _CollectionItem({required this.serie});
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
                  builder: (context) => SeriePage(serie: value),
                ),
              );
            });
          },
          child: Image.network(
            _api.getSeriePoster(serie.poster!),
            fit: BoxFit.cover,
            width: width * 0.65,
            height: width,
            errorBuilder: (context, error, stackTrace) {
              return const Text("Não foi possível carregar a imagem");
            },
          ),
        ),
      ),
    );
  }
}
