import 'package:flutter/material.dart';
import 'package:teleceriado/models/episodio.dart';
import 'package:teleceriado/screens/serie/widgets/edit_episodio.dart';
import 'package:teleceriado/screens/serie/widgets/options_dialog.dart';
import 'package:teleceriado/screens/serie/widgets/serie_header.dart';
import '../../models/serie_model.dart';

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
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.only(top:3),
            child: Icon(
              Icons.favorite_border_rounded,
              size: 40,
            ),
          ),
        ),
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: SerieHeader(
                  serie: _serie,
                )),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    Episodio episodio =
                        Episodio.fromMap(_serie.episodios![index]);
                    return _EpisodioItem(
                      episodio: episodio,
                      episodioImagem:
                          _serie.imagens![index % _serie.imagens!.length],
                    );
                  }, childCount: _serie.episodios!.length),
                ),
              ],
            ),
            SizedBox(
              // color: Colors.lime,
              height: height * 0.1,
              width: width,
              child: Row(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _EpisodioItem extends StatelessWidget {
  final Episodio episodio;
  final String episodioImagem;
  const _EpisodioItem({required this.episodio, required this.episodioImagem});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) =>
                EditEpisodio(episodio: episodio, imagemUrl: episodioImagem));
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
              Image.network(
                episodioImagem,
                fit: BoxFit.cover,
                width: width * 0.3,
                height: height * 0.15,
                alignment: Alignment.centerLeft,
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
                          '${episodio.idEpisodio}. ${episodio.nome}',
                          style: const TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.65,
                      height: height * 0.07,
                      child: const Text('Add descrição...'),
                    ),
                    const Expanded(child: SizedBox()),
                    Text('Estreia: ${episodio.estreia}')
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
