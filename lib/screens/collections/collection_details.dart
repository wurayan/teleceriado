import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/models/collection.dart';
import 'package:teleceriado/screens/collections/widget/seguir_colecao.dart';
import 'package:teleceriado/services/api_service.dart';
import '../../models/serie.dart';
import '../../models/usuario.dart';
import '../../services/user_dao/firebase_export.dart';
import '../serie/serie_details.dart';

class CollectionDetails extends StatefulWidget {
  final Collection colecao;
  const CollectionDetails({super.key, required this.colecao});

  @override
  State<CollectionDetails> createState() => _CollectionDetailsState();
}

class _CollectionDetailsState extends State<CollectionDetails> {
  final FirebaseCollections _collections = FirebaseCollections();
  final FirebaseSeries _series = FirebaseSeries();
  // List<Serie>? series;
  // Collection? collection;

  @override
  void initState() {
    // _collections.getCollectionInfo(widget.collectionId, userId: widget.userId).then((value) {
    //   collection = value;
    //   _series.getCollectionSeries(widget.collectionId, userId: widget.userId).then((value) {
    //     series = value;
    //     setState(() {});
    //   });
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: widget.colecao.series == null
            ? const Loading()
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _Header(
                      collection: widget.colecao,
                    ),
                  ),
                  widget.colecao.series!.isEmpty
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
                      : _Body(series: widget.colecao.series!)
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
        Column(
          children: [
            Container(
              width: width,
              height: height * 0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: Image.network(
                  collection.imagem!,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Text("Não foi possível carregar a imagem"),
                  ),
                ).image,
                fit: BoxFit.cover,
              )),
              child: Container(
                width: width,
                height: height * 0.2,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.blueGrey[900]!],
                )),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: height * 0.01, left: width * 0.05),
                    child: Text(collection.nome!,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.15,
              width: width,
              child: Center(
                child: Text(
                  collection.descricao == null || collection.descricao!.isEmpty
                      ? "Essa coleção não possui descrição.\n Então ela é um enigma, tente adivinhar o tema."
                      : collection.descricao!,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.02, right: width * 0.05, bottom: height*0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Qtde de Séries: ${collection.series?.length ?? "Erro"}",
                  ),
                  Visibility(
                    visible:
                        Provider.of<Usuario>(context).uid != collection.dono,
                    child: SeguirColecao(colecao: collection),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 3,
              thickness: 1,
              color: Colors.white,
            )
          ],
        ),

        //BOTOES NO TOPO DA TELA
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
