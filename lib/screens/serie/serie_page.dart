import 'package:teleceriado/screens/serie/widgets/list_view_episodios.dart';
import 'package:teleceriado/screens/serie/widgets/options_dialog.dart';
import 'package:teleceriado/screens/serie/widgets/serie_details.dart';
import 'package:teleceriado/screens/serie/widgets/serie_header.dart';
import '../../models/serie.dart';
import '../../services/user_dao/firebase_export.dart';
import 'package:pixel_snap/material.dart';

class SeriePage extends StatefulWidget {
  final Serie serie;
  const SeriePage({super.key, required this.serie});

  @override
  State<SeriePage> createState() => _SeriePageState();
}

class _SeriePageState extends State<SeriePage> {
  final FirebaseSeries _series = FirebaseSeries();
  late Serie _serie;
  bool backdropEdited = false;
  int temporada = 1;
  bool showDetails = false;

  getEdited(Serie serie) async {
    Map? map = await _series.getEditedSerie(serie.id!);
    if (map == null) return;
    map["descricao"] != null ? serie.descricao = map["descricao"] : null;
    map["backdrop"] != null ? serie.backdrop = map["backdrop"] : null;
    setState(() {});
  }

  changeView(bool value) {
    showDetails = value;
    setState(() {});
  }

  @override
  void initState() {
    _serie = widget.serie;
    getEdited(_serie);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SerieHeader(
                    serie: _serie,
                    backdropEdited: backdropEdited,
                    function: changeView,
                  ),
                ),
                showDetails
                    ? SerieDetails(serie: _serie)
                    : ListBuilder(
                        serie: _serie,
                      )
              ],
            ),

            //AQUI É SO OS BOTAO NO TOPO
            Row(
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
                  child: OptionsButton(
                    serie: _serie,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
