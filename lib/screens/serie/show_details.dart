import 'package:flutter/material.dart';
import 'package:teleceriado/models/episodio.dart';
import 'package:teleceriado/screens/serie/widgets/action_buttons.dart';
import 'package:teleceriado/screens/serie/widgets/edit_episodio.dart';
import 'package:teleceriado/screens/serie/widgets/options_dialog.dart';
import 'package:teleceriado/screens/serie/widgets/serie_header.dart';
import 'package:teleceriado/services/api_service.dart';
import '../../models/serie.dart';

class ShowDetails extends StatefulWidget {
  final Serie serie;
  const ShowDetails({super.key, required this.serie});

  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  late Serie _serie;

  @override
  void initState() {
    _serie = widget.serie;
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
                    child: const OptionsButton())
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
  final ApiService _api = ApiService();
  @override
  void initState() {
    _api.getEpisodios(widget.idSerie, 1).then((value) {
      episodios = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return episodios.isEmpty
        ? const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator(value: null)),
        )
        : SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              Episodio episodio = episodios[index];
              return _EpisodioItem(
                  episodio: episodio);
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
            builder: (context) =>
                EditEpisodio(episodio: episodio));
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
              episodio.imagem != null ? 
              Image.network(
                _api.getSeriePoster(episodio.imagem!),
                fit: BoxFit.cover,
                width: width * 0.3,
                height: height * 0.15,
                alignment: Alignment.centerLeft,
              ) : SizedBox(
                width: width*0.3,
                height: height*0.15,
                child: const Center(
                  child: Text('Imagem não encontrada ;-;',
                  textAlign: TextAlign.center,),
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
                      child: Text(episodio.descricao!, overflow: TextOverflow.fade, maxLines: 3,),
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
