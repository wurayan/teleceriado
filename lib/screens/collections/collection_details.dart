import 'package:flutter/material.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/models/collection.dart';
import 'package:teleceriado/services/api_service.dart';
import '../../models/serie.dart';
import '../../services/user_dao/firebase_export.dart';
import '../serie/serie_details.dart';

class CollectionDetails extends StatefulWidget {
  final String collectionId;
  final String? userId;
  const CollectionDetails({super.key, required this.collectionId, this.userId});

  @override
  State<CollectionDetails> createState() => _CollectionDetailsState();
}

class _CollectionDetailsState extends State<CollectionDetails> {
  final FirebaseCollections _collections = FirebaseCollections();
  final FirebaseSeries _series = FirebaseSeries();
  List<Serie>? series;
  Collection? collection;

  @override
  void initState() {
    _collections.getCollectionInfo(widget.collectionId, userId: widget.userId).then((value) {
      collection = value;
      _series.getCollectionSeries(widget.collectionId, userId: widget.userId).then((value) {
        series = value;
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: series == null
            ? const Loading()
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _Header(
                      collection: collection!,
                    ),
                  ),
                  series!.isEmpty
                      ? SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(top: height * 0.1),
                            child: const Center(
                              child: Text(
                                "T-T Não tem séries nessa coleção ainda",
                              ),
                            ),
                          ),
                        )
                      : _Body(series: series!)
                ],
              ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final Collection collection;
  const _Header({required this.collection});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        SizedBox(
          width: width,
          height: height * 0.2,
          child: collection.imagem != null
              ? Image.network(
                  collection.imagem!,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        Container(
          width: width,
          height: height * 0.2,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.blueGrey[900]!])),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.02, right: width * 0.02, top: height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const Dialog(
                          child: Text("Nada Ainda"),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.edit_rounded),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.1, bottom: height * 0.02, left: width * 0.05),
              child: Text(
                collection.nome!,
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Flexible(
              child: Padding(
                padding:
                    EdgeInsets.only(left: width * 0.03, bottom: height * 0.03),
                child: Text(collection.descricao ?? "Sem descrição...."),
              ),
            ),
            const Divider(
              height: 3,
              thickness: 1,
              color: Colors.white,
            )
          ],
        )
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<Serie> series;
  _Body({required this.series});

  final ApiService _api = ApiService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return SliverPadding(
      padding: const EdgeInsets.only(left: 3, top: 3, right: 3),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            Serie serie = series[index];
            return Container(
              decoration: BoxDecoration(
                  border:
                      Border.all(width: 0.5, color: Colors.blueGrey.shade700)),
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
            );
          },
          childCount: series.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            childAspectRatio: 0.7),
      ),
    );
  }
}
