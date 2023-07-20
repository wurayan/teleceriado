import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teleceriado/screens/profile/widget/choose_serie_searchbar.dart';

import '../../../components/loading.dart';
import '../../../models/serie.dart';
import '../../../services/api_service.dart';

class ChooseSerie extends StatefulWidget {
  const ChooseSerie({super.key});

  @override
  State<ChooseSerie> createState() => _ChooseSerieState();
}

class _ChooseSerieState extends State<ChooseSerie> {
  final ApiService _api = ApiService();
  List<Serie>? series;

  getSeries(String? query) async {
    series = query == null
        ? await _api.getTrending()
        : await _api.searchSerie(query);
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getSeries(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Dialog(
      child: SizedBox(
        height: height * 0.6,
        width: width * 0.9,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.1,
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: Colors.black45,
                        height: 1,
                      )
                    ],
                  ),
                ),
                series == null
                    ? const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Loading(),
                        ),
                      )
                    : series!.isEmpty
                        ? const SliverToBoxAdapter(
                            child: Center(
                              child: Text(
                                "Não achamos nada ;-;",
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : SliverGrid.builder(
                            itemCount: series!.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 2,
                                    crossAxisSpacing: 2,
                                    childAspectRatio: 0.7),
                            itemBuilder: (context, index) => _SerieItem(
                              serie: series![index],
                            ),
                          )
              ],
            ),
            ChooseSerieSearchBar(function: getSeries),
          ],
        ),
      ),
    );
  }
}

class _SerieItem extends StatelessWidget {
  final Serie serie;
  _SerieItem({required this.serie});
  final ApiService _api = ApiService();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, serie);
      },
      child: SizedBox(
        child: serie.poster != null
            ? CachedNetworkImage(
                imageUrl: _api.getSeriePoster(serie.poster!),
                errorWidget: (context, url, error) => const Text(
                  "Não foi possível carregar a imagem ;-;",
                  textAlign: TextAlign.center,
                ),
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) => Align(
                  alignment: Alignment.center,
                  child: Text(
                    serie.nome!,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Align(
                alignment: Alignment.center,
                child: Text(
                  serie.nome!,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    );
  }
}
