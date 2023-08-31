import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:teleceriado/components/loading.dart';
import '../../../models/episodio.dart';
import '../../../models/usuario.dart';
import '../../../services/user_dao/firebase_export.dart';
import 'dart:math' as math;

class ProfileComentarios extends StatefulWidget {
  final Usuario usuario;
  const ProfileComentarios({super.key, required this.usuario});

  @override
  State<ProfileComentarios> createState() => _ProfileComentariosState();
}

class _ProfileComentariosState extends State<ProfileComentarios>
    with AutomaticKeepAliveClientMixin {
  final FirebaseEpisodios _episodios = FirebaseEpisodios();
  List<Episodio>? episodios;

  getEpisodios(Usuario usuario) async {
    episodios = await _episodios.getAllEditedEpisodios(usuario.uid!);
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getEpisodios(widget.usuario);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final double height = MediaQuery.of(context).size.height;
    return episodios == null
        ? const Column(
            mainAxisSize: MainAxisSize.min,
            children: [Loading(), Expanded(child: SizedBox())],
          )
        : episodios!.isEmpty
            ? Padding(
                padding: EdgeInsets.only(top: height * 0.05),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: "Que tal comentar os Episódios que você mais gosta?",
                    style: TextStyle(fontSize: 16),
                    children: [
                      TextSpan(
                        text: "Ou mais odeia...",
                        style:
                            TextStyle(decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(top: height * 0.01),
                child: MasonryGridView.builder(
                  itemCount: episodios!.length,
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 6,
                  itemBuilder: (context, index) {
                    Episodio episodio = episodios![index];
                    return _ComentarioCard(episodio: episodio);
                  },
                ),
              );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ComentarioCard extends StatelessWidget {
  final Episodio episodio;
  const _ComentarioCard({required this.episodio});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[800],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.01, top: height * 0.005),
            child: Text(
              episodio.serie ?? "Erro",
              style: const TextStyle(
                  fontWeight: FontWeight.w300, fontSize: 14, letterSpacing: 1),
              maxLines: 2,
              overflow: TextOverflow.clip,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.02),
            child: Text(
              "${episodio.numero}. ${episodio.nome}",
              maxLines: 2,
              overflow: TextOverflow.clip,
              style: const TextStyle(fontSize: 15, letterSpacing: 0.5),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: width * 0.01, right: width * 0.01, bottom: height * 0.01),
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: const Icon(
                        Icons.format_quote,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: episodio.descricao,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
