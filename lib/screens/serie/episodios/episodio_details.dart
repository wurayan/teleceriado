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
                      colors: [Colors.transparent, Colors.blueGrey[900]!])),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: InkWell(
                  onTap: (){reload();},
                  child: Padding(
                    padding: EdgeInsets.only(left: width*0.02),
                    child: RichText(
                      text: TextSpan(
                          text: "${episodio.numero}. ${episodio.nome}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                          children: const [
                            WidgetSpan(
                              child: Icon(Icons.edit_rounded, size: 20),
                            ),
                          ],),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        InkWell(
          onTap: (){
            reload();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: width*0.02, right: width*0.03, top: height*0.01
            ),
            child: RichText(
              text: TextSpan(
                text: "  ",
                style: const TextStyle(
                  fontSize: 16
                ),
                children: [
                  TextSpan(
                    text: episodio.descricao ?? "Toque para adicionar uma descrição..."
                  ),
                  const WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.edit_rounded,
                        size: 20
                      ),
                    )
                  )
                ]
              ),
            ),
          ),
        )
      ],
    );
  }
}
