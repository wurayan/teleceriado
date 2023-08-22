import 'package:pixel_snap/material.dart';
import 'package:teleceriado/screens/serie/widgets/action_buttons.dart';
import 'package:teleceriado/screens/serie/widgets/options_bar.dart';
import 'package:teleceriado/services/api_service.dart';

import '../../../models/serie.dart';

class SerieHeader extends StatelessWidget {
  final Serie serie;
  final bool backdropEdited;
  final Function function;
  SerieHeader(
      {super.key,
      required this.serie,
      required this.backdropEdited,
      required this.function});
  final ApiService _api = ApiService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          ),
          width: width,
          height: height * 0.25,
          clipBehavior: Clip.hardEdge,
          child: Image.network(
            backdropEdited
                ? serie.backdrop!
                : _api.getSeriePoster(serie.backdrop!),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: height * 0.25,
              width: width,
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                ),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: width * 0.9,
                      child: Text(
                        serie.nome!,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(width * 0.02),
                child: Text(
                  serie.descricao == null ? 'Sem descrição' : serie.descricao!,
                ),
              ),
            ),
            ActionButtons(serie: serie),
            const Divider(
              color: Colors.black54,
              thickness: 1,
              height: 2,
            ),
            SizedBox(
              height: height * 0.05,
              width: width * 0.99,
              child: OptionsBar(function: function),
            )
          ],
        ),
      ],
    );
  }
}
