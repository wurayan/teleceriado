import 'package:pixel_snap/material.dart';
import 'package:provider/provider.dart';
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
  final FirebaseUsers _users = FirebaseUsers();
  late Collection colecao;
  Usuario? dono;

  getOwnerData(String userId) async {
    dono = await _users.getUserdata(userId: userId);
    if (mounted) setState(() {});
  }

  isOwner(context, String colecaoDono) {
    return Provider.of<Usuario>(context).uid == colecaoDono;
  }

  @override
  void initState() {
    colecao = widget.colecao;
    getOwnerData(colecao.dono!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _Header(
                collection: colecao,
                dono: isOwner(context, colecao.dono!) ? null : dono,
              ),
            ),
            colecao.series == null || colecao.series!.isEmpty
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
  final Usuario? dono;
  const _Header({required this.collection, this.dono});

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
                ),
              ),
              child: Container(
                width: width,
                height: height * 0.205,
                decoration: BoxDecoration(
                  // color: Colors.transparent,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.blueGrey[900]!],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: height * 0.005, left: width * 0.05),
                    child: Text(
                      collection.nome!,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.02, right: width*0.05),
              child: Row(
                children: [
                  dono!.avatar != null
                      ? Container(
                          width: width * 0.065,
                          height: width * 0.065,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.white),
                            image: DecorationImage(
                              image: Image.network(
                                dono!.avatar!,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(
                                  child: Text("Erro"),
                                ),
                              ).image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.account_circle_outlined,
                          size: width * 0.065,
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      dono!.username ?? dono!.uid!.substring(0, 20),
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  const Text("Seguidores?")
                ],
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
              padding: EdgeInsets.only(
                  left: width * 0.02,
                  right: width * 0.05,
                  bottom: height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${collection.series?.length ?? 0} Séries",
                      style: const TextStyle(fontWeight: FontWeight.w300)),
                  Visibility(
                    visible: dono != null,
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
