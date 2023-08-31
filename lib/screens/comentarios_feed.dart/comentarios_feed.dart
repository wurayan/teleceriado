import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/components/loading_frases.dart';
import 'package:teleceriado/screens/usuarios/user_page.dart';
import 'package:teleceriado/services/api_service.dart';
import 'package:teleceriado/services/user_dao/firebase_export.dart';

import '../../models/episodio.dart';

class ComentariosFeed extends StatefulWidget {
  const ComentariosFeed({super.key});

  @override
  State<ComentariosFeed> createState() => _ComentariosFeedState();
}

class _ComentariosFeedState extends State<ComentariosFeed> {
  final FirebaseFeed _feed = FirebaseFeed();
  List<Episodio> episodios = [];
  bool loading = true;

  getFeed() async {
    episodios = await _feed.getFeed();
    loading = false;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getFeed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Loading(),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: LoadingFrases(loading: loading),
              ),
            ],
          )
        : episodios.isEmpty
            ? const Center(
                child: Text("Nada para ver aqui velhinho."),
              )
            : CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 5,
                    ),
                  ),
                  SliverMasonryGrid(
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 5,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    delegate: SliverChildBuilderDelegate(
                      childCount: episodios.length,
                      (context, index) =>
                          _ComentarioItem(episodio: episodios[index]),
                    ),
                  ),
                ],
              );
  }
}

class _ComentarioItem extends StatelessWidget {
  final Episodio episodio;
  _ComentarioItem({required this.episodio});
  final ApiService _api = ApiService();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        if (episodio.criadorId == null) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserPage(usuarioId: episodio.criadorId!),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.grey[900]),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * 0.15,
              width: double.infinity,
              decoration: BoxDecoration(
                image: episodio.imagem != null
                    ? DecorationImage(
                        image: Image.network(
                          _api.getSeriePoster(episodio.imagem!),
                          errorBuilder: (context, error, stackTrace) =>
                              const Text("Imagem não encontrada"),
                        ).image,
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.grey[900]!],
                  ),
                ),
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    "${episodio.numero}. ${episodio.nome}",
                    style: const TextStyle(letterSpacing: 0.5),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                "${episodio.serie}",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                    letterSpacing: 0.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 2),
              child: Text(
                "  \"${episodio.descricao}\"",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 20),
              child: Text(
                "Criado por ${episodio.criador}",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
