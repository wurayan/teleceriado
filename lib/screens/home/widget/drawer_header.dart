import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/serie.dart';
import '../../../models/usuario.dart';
import '../../../services/api_service.dart';
import 'change_userdata.dart';

class DrawerHeaderInfo extends StatefulWidget {
  const DrawerHeaderInfo({super.key});

  @override
  State<DrawerHeaderInfo> createState() => _DrawerHeaderInfoState();
}

class _DrawerHeaderInfoState extends State<DrawerHeaderInfo> {
  final ApiService _api = ApiService();
  String? header;
  bool first = true;

  getHeader(context) async {
    int? id = Provider.of<Usuario>(context).assistindoAgora ??
        Provider.of<Usuario>(context).serieFavorita;
    if (id == null) return;
    Serie serie = await _api.getSerie(id, 1);
    header = serie.backdrop;
    first = false;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if(first) getHeader(context);
    print("rebuild surtado");
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: header != null
                  ? DecorationImage(
                      image: Image.network(
                        _api.getSeriePoster(header!),
                        errorBuilder: (context, error, stackTrace) =>
                            const Text("Erro ao localizar a imagem ;-;"),
                      ).image,
                      fit: BoxFit.cover,
                    )
                  : null,
                  color: Colors.white30),
          child: Container(
            width: double.infinity,
            height: height * 0.17,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [
                    0,
                    0.9
                  ],
                  colors: [
                    Colors.transparent,
                    Theme.of(context).scaffoldBackgroundColor
                  ]),
              
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.2,
                  height: width * 0.2,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.grey[300]!)),
                  child: Provider.of<Usuario>(context).avatar != null
                      ? Image.network(
                          Provider.of<Usuario>(context).avatar!,
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Text(
                            "Sem Imagem",
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.01),
                  child: Text(
                      Provider.of<Usuario>(context).username ??
                          Provider.of<Usuario>(context).uid ??
                          "erro",
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => const ChangeUserdata()).then((value) {
                if (value == true) {
                  setState(() {});
                }
              });
            },
            icon: const Icon(
              Icons.edit_rounded,
            ),
          ),
        )
      ],
    );
  }
}
