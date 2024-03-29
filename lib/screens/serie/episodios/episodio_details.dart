import 'package:flutter/material.dart';
import 'package:teleceriado/models/episodio.dart';

import '../../../services/api_service.dart';

class EpisodioDetails extends StatelessWidget {
  final VoidCallback reload;
  final Episodio episodio;
  EpisodioDetails({super.key, required this.reload, required this.episodio});

  final ApiService _api = ApiService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: height * 0.2,
              child: episodio.imagem != null
                  ? Image.network(
                      episodio.wasEdited == true
                          ? episodio.imagem!
                          : _api.getSeriePoster(episodio.imagem!),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    )
                  : const Center(
                      child: Text(
                          "Não achamos nenhuma imagem para esse episódio ;-;"),
                    ),
            ),
            Container(
              width: double.infinity,
              height: height * 0.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Theme.of(context).dialogBackgroundColor,
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: InkWell(
                  onTap: () {
                    reload();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.02),
                    child: RichText(
                      text: TextSpan(
                        text: "${episodio.numero}. ${episodio.nome} ",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        children: const [
                          WidgetSpan(
                            child: Icon(Icons.edit_rounded, size: 20),
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        InkWell(
          onTap: () {
            reload();
          },
          child: Padding(
            padding: EdgeInsets.only(
                left: width * 0.02, right: width * 0.03, top: height * 0.01),
            child: RichText(
              text: TextSpan(
                text: "  ",
                style: const TextStyle(fontSize: 16),
                children: [
                  TextSpan(
                      text: episodio.descricao ??
                          "Toque para adicionar uma descrição..."),
                ],
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 7,
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding:
                EdgeInsets.only(right: width * 0.03, bottom: height * 0.015),
            child: InkWell(
              onTap: () {
                reload();
              },
              child: const Icon(
                Icons.edit_rounded,
                size: 25,
              ),
            ),
          ),
        )
      ],
    );
  }
}
