import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:teleceriado/utils/utils.dart';
import '../../../models/episodio.dart';
import '../../../services/api_service.dart';

class ComentariosScreen extends StatelessWidget {
  final List<Episodio> episodios;
  const ComentariosScreen({super.key, required this.episodios});

  @override
  Widget build(BuildContext context) {
    return episodios.isEmpty
        ? Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: const Text(
                "Essa pessoa ainda não compartilhou sua genialidade com o mundo.\n\nTalvez ela seja tímida?",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        : MasonryGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 6,
            itemCount: episodios.length,
            itemBuilder: (BuildContext context, int index) {
              return index == 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: ComentarioCard(episodio: episodios[index]),
                    )
                  : ComentarioCard(episodio: episodios[index]);
            },
          );
  }
}

class ComentarioCard extends StatefulWidget {
  final Episodio episodio;
  const ComentarioCard({super.key, required this.episodio});

  @override
  State<ComentarioCard> createState() => _ComentarioCardState();
}

class _ComentarioCardState extends State<ComentarioCard> {
  final ApiService _api = ApiService();
  int? lightness;

  checkLight(Episodio episodio) async {
    lightness = await lightnessCheck(episodio);
    setState(() {});
  }

  @override
  void initState() {
    checkLight(widget.episodio);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: lightness != null
            ? DecorationImage(
                image: Image.network(
                  widget.episodio.wasEdited == true
                      ? widget.episodio.imagem!
                      : _api.getSeriePoster(widget.episodio.imagem!),
                ).image,
                fit: BoxFit.cover,
                colorFilter: colorFilter(lightness!),
              )
            : null,
        color: Colors.blueGrey[800],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Text(
              widget.episodio.serie ?? "Erro",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.clip,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(
              "Temp. ${widget.episodio.temporada} Ep. ${widget.episodio.numero}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 10, 5),
            child: Text(
              widget.episodio.nome!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.clip,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '" ${widget.episodio.descricao ?? "Sem descrição"}"',
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
