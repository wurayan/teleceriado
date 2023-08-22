import 'package:flutter/material.dart';
import 'package:teleceriado/screens/serie/widgets/temporada_select.dart';

import '../../../components/loading.dart';
import '../../../models/episodio.dart';
import '../../../models/serie.dart';
import '../../../services/api_service.dart';
import '../../../services/user_dao/firebase_export.dart';
import '../episodios/wrapper.dart';

class ListBuilder extends StatefulWidget {
  final Serie serie;
  const ListBuilder({super.key, required this.serie});

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder>
    with AutomaticKeepAliveClientMixin {
  List<Episodio> episodios = [];
  Map<int, Episodio>? editados;
  final ApiService _api = ApiService();
  final FirebaseEpisodios _episodios = FirebaseEpisodios();

  _getEpisodios(int temporada) async {
    int id = widget.serie.id!;
    episodios = await _api.getEpisodios(id, temporada);
    editados = await _episodios.getEditedEpisodio(id, temporada);
    if (editados == null) return;
    editados!.forEach((key, value) {
      Episodio ep = episodios[key - 1];
      value.descricao != null ? ep.descricao = value.descricao : null;
      value.nome != null ? ep.nome = value.nome : null;
      if (value.imagem != null) {
        ep.imagem = value.imagem;
        ep.wasEdited = true;
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    _getEpisodios(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return episodios.isEmpty
        ? const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: Loading(),
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              Episodio episodio = episodios[index];
              return index == 0
                  ? SelectTemporada(
                      update: _getEpisodios,
                      qtdeTemporadas: widget.serie.temporadasqtde ?? 1,
                      child: _EpisodioItem(episodio: episodio),
                    )
                  : _EpisodioItem(episodio: episodio);
            }, childCount: episodios.length),
          );
  }

  @override
  bool get wantKeepAlive => true;
}

class _EpisodioItem extends StatelessWidget {
  final Episodio episodio;
  _EpisodioItem({required this.episodio});
  final ApiService _api = ApiService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => EpisodioWrapper(episodio: episodio),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.002),
        child: Container(
          width: width,
          height: height * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: const Color.fromARGB(255, 57, 57, 58),
          ),
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: [
              episodio.imagem != null
                  ? Image.network(
                      episodio.wasEdited == true
                          ? episodio.imagem!
                          : _api.getSeriePoster(episodio.imagem!),
                      fit: BoxFit.cover,
                      width: width * 0.3,
                      height: height * 0.15,
                      alignment: Alignment.centerLeft,
                    )
                  : SizedBox(
                      width: width * 0.3,
                      height: height * 0.15,
                      child: const Center(
                        child: Text(
                          'Imagem não encontrada ;-;',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * 0.01, horizontal: width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.01, bottom: height * 0.01),
                      child: SizedBox(
                        width: width * 0.65,
                        child: Text(
                          '${episodio.numero}. ${episodio.nome}',
                          style: const TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.65,
                      height: height * 0.07,
                      child: Text(
                        episodio.descricao!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
