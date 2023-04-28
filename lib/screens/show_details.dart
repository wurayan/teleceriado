import 'package:flutter/material.dart';
import 'package:teleceriado/models/episodio.dart';
import 'package:teleceriado/screens/widgets/edit_episodio.dart';
import '../models/serie_model.dart';
import '../utils/utils.dart';

class ShowDetails extends StatefulWidget {
  final Serie serie;
  const ShowDetails({super.key, required this.serie});

  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  Serie? _serie;
  int index = 1;

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
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _serie!.imagens == null || _serie!.imagens!.isEmpty
                          ? const Center(
                              child: Text(
                                'Imagem não encontrada ;-;',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15)),
                              ),
                              width: width,
                              height: height * 0.2,
                              clipBehavior: Clip.hardEdge,
                              child: Image.network(
                                _serie!.imagens![0],
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                            ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.01, left: width * 0.02),
                        child: Text(
                          _serie!.nome,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: width * 0.01),
                            child: Text(situacao.containsKey(_serie!.status)
                                ? 'Situação: ${situacao[_serie!.status]}'
                                : 'Situação: ${_serie!.status}'),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(width * 0.02),
                        child: SizedBox(
                          height: height * 0.1,
                          width: width,
                          child: Text(
                            _serie!.descricao == null
                                ? 'Sem descrição'
                                : _serie!.descricao!,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.01),
                        child: const Divider(
                          color: Colors.black54,
                          thickness: 1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration:const BoxDecoration(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                              
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  // left: width * 0.02, 
                                  bottom: height * 0.01),
                              child: const Text(
                                'Episódios',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                          
                          Padding(
                            padding: EdgeInsets.only(bottom: height*0.01),
                            child: const Text('Detalhes',
                            style: TextStyle(fontSize: 18)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    Episodio episodio =
                        Episodio.fromMap(_serie!.episodios![index]);
                    return _EpisodioItem(
                        episodio: episodio,
                        episodioImagem: _serie!.imagens![1]);
                  }, childCount: _serie!.episodios!.length),
                ),
              ],
            ),
            Container(
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
                    child: InkWell(
                      onTap: () {},
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white24,
                        child: Icon(
                          Icons.more_vert_rounded,
                          size: 32,
                        ),
                      ),
                    ),
                  )
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
  const _EpisodioItem(
      {super.key, required this.episodio, required this.episodioImagem});

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
