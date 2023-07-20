import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:teleceriado/models/error_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/serie.dart';

class SerieDetails extends StatelessWidget {
  final Serie serie;
  const SerieDetails({super.key, required this.serie});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: height * 0.02),
              child: RichText(
                text: TextSpan(
                  text: "Lançada em: ",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                        text: serie.release != null
                            ? UtilData.obterDataDDMMAAAA(
                                DateTime.parse(serie.release!))
                            : "Sei lá",
                        style: const TextStyle(fontWeight: FontWeight.w300))
                  ],
                ),
              ),
            ),
            Text(serie.situacao ?? false ? "Em andamento" : "Finalizada"),
            const Text("Gêneros:"),
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.03,
                  top: height * 0.005,
                  bottom: height * 0.01),
              child: Text(serie.generos != null
                  ? serie.generos!.join(", ")
                  : "O que você achar."),
            ),
            Text(
                "País: ${serie.pais != null ? serie.pais!.join(", ") : "Terra de Ninguém"}"),
            Padding(
              padding: EdgeInsets.only(top: height * 0.005),
              child: Text("Temporadas: ${serie.temporadasqtde}"),
            ),
            Text("Episódios: ${serie.episodiosqtde}"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.005),
              child: GestureDetector(
                onTap: () {
                  if (serie.link == null || serie.link!.isEmpty) return;
                  _urlLaucher(serie.link!);
                },
                child: RichText(
                  text: TextSpan(
                    text: "Link: ",
                    style: const TextStyle(fontSize: 16),
                    children: [
                      TextSpan(
                        text: serie.link ?? "Não tem.",
                        style: serie.link != null
                            ? TextStyle(color: Colors.blue[300])
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text("Emissoras: ${serie.emissoras!.join(", ")}"),
            Text("Produtoras: ${serie.produtoras!.join(", ")}")
          ],
        ),
      ),
    );
  }

  _urlLaucher(String link) async {
    Uri url = Uri.parse(link);
    launchUrl(url, mode: LaunchMode.externalApplication).onError(
      (error, stackTrace) {
        ErrorHandler.showSimple(
            "Sinto muito, não foi possível acessar o Link ;-;");
        throw Exception(error);
      },
    );
  }
}
