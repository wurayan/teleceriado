import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/update_seguindo.dart';
import 'package:teleceriado/screens/profile/widget/about_you_button.dart';

import '../../../models/serie.dart';
import '../../../models/usuario.dart';
import '../../../services/api_service.dart';
import '../../../services/user_dao/firebase_export.dart';
import 'choose_serie.dart';

class AboutYou extends StatefulWidget {
  final Usuario usuario;
  const AboutYou({super.key, required this.usuario});

  @override
  State<AboutYou> createState() => _AboutYouState();
}

class _AboutYouState extends State<AboutYou> {
  final ApiService _api = ApiService();
  String? favorita;
  String? assistindoAgora;

  getImages(Usuario usuario) async {
    if (usuario.serieFavorita == null && usuario.assistindoAgora == null)
      return;

    Serie serie;

    if (usuario.serieFavorita != null) {
      serie = await _api.getSerie(usuario.serieFavorita!, 1);
      favorita = serie.backdrop;
    }
    if (usuario.assistindoAgora != null) {
      serie = await _api.getSerie(usuario.assistindoAgora!, 1);
      assistindoAgora = serie.backdrop;
    }
    setState(() {});
  }

  @override
  void initState() {
    getImages(widget.usuario);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AboutYouButton(
            function: () {
              chooseSerie(context, false);
            },
            image: assistindoAgora,
            title: "Assistindo agora"),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        ),
        AboutYouButton(
            function: () {
              chooseSerie(context, true);
            },
            image: favorita,
            title: "Série favorita")
      ],
    );
  }

  chooseSerie(context, bool isFavorite) async {
    final FirebaseUsers users = FirebaseUsers();
    final ApiService api = ApiService();
    Serie? serie = await showDialog(
      context: context,
      builder: (context) => const ChooseSerie(),
    );
    if (serie == null) return;
    if (isFavorite) {
      await users.saveFavorita(serie.id!);
      Provider.of<Usuario>(context, listen: false).serieFavorita = serie.id!;
      
    } else {
      await users.saveAssistindoAgora(serie.id!);
      Provider.of<Usuario>(context, listen: false).assistindoAgora = serie.id!;

    }

    getImages(Provider.of<Usuario>(context, listen: false));
    Serie header = await api.getSerie(serie.id!, 1);
      if(header.backdrop==null||header.backdrop!.isEmpty) return;
      Provider.of<Usuario>(context, listen: false).header = api.getSeriePoster(header.backdrop!);
      Provider.of<UpdateSeguindo>(context, listen: false).headerChanged = true;
  }
}
