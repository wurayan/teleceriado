import 'package:flutter/material.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/models/episodio.dart';
import 'package:teleceriado/screens/serie/episodios/wrapper.dart';
import 'package:teleceriado/screens/serie/widgets/options_dialog.dart';
import 'package:teleceriado/screens/serie/widgets/serie_header.dart';
import 'package:teleceriado/services/api_service.dart';
import '../../models/serie.dart';
import '../../services/user_dao/user_collections.dart';

class ShowDetails extends StatefulWidget {
  final Serie serie;
  const ShowDetails({super.key, required this.serie});

  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  final FirebaseCollections _collection = FirebaseCollections();

  late Serie _serie;
  bool backdropEdited = false;

  getEdited(Serie serie) async {
    Map? map = await _collection.getEditedSerie(serie.id!);
    if (map != null) {
      if (map["descricao"] != null && map["backdrop"] != null) {
        serie.descricao = map["descricao"];
        serie.backdrop = map["backdrop"];
        backdropEdited = true;
      } else if (map["backdrop"] != null) {
        backdropEdited = true;
        serie.backdrop = map["backdrop"];
      } else {
        serie.descricao = map["descricao"];
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    _serie = widget.serie;
    getEdited(_serie);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: SerieHeader(
                  serie: _serie,
                  backdropEdited: backdropEdited,
                )),
                ListBuilder(idSerie: _serie.id!)
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: width * 0.01),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 32,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(width * 0.02),
                    child: OptionsButton(
                      serieId: _serie.id!,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ListBuilder extends StatefulWidget {
  final int idSerie;
  const ListBuilder({super.key, required this.idSerie});

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  List<Episodio> episodios = [];
  Map<int, Episodio>? editados;
  final ApiService _api = ApiService();
  final FirebaseCollections _collection = FirebaseCollections();

  _getEpisodios(int serieId, int temporada) async {
    episodios = await _api.getEpisodios(serieId, temporada);
    editados = await _collection.getEditedEpisodio(serieId, temporada);
    if (editados != null) {
      editados!.forEach((key, value) {
        Episodio ep = episodios[key - 1];
        value.descricao != null ? ep.descricao = value.descricao : null;
        value.nome != null ? ep.nome = value.nome : null;
        if (value.imagem != null) {
          ep.imagem = value.imagem;
          ep.wasEdited = true;
        }
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    _getEpisodios(widget.idSerie, 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return episodios.isEmpty
        ? SliverToBoxAdapter(
            child: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
            child: const Loading(),
          ))
        : SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              Episodio episodio = episodios[index];

              return _EpisodioItem(episodio: episodio);
            }, childCount: episodios.length),
          );
  }
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
            color: const Color.fromARGB(255, 57, 57, 58),
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
                        overflow: TextOverflow.fade,
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
