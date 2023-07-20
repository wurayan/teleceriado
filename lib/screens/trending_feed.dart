import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/components/loading_frases.dart';
import 'package:teleceriado/screens/serie/serie_page.dart';
import 'package:teleceriado/services/api_service.dart';
import '../models/serie.dart';

class TrendingFeed extends StatefulWidget {
  const TrendingFeed({super.key});

  @override
  State<TrendingFeed> createState() => _TrendingFeedState();
}

class _TrendingFeedState extends State<TrendingFeed>
    with AutomaticKeepAliveClientMixin {
  final ApiService _api = ApiService();
  List<Serie> seriesPopulares = [];

  getTrending() async {
    seriesPopulares = await _api.getTrending();
    setState(() {});
  }

  @override
  void initState() {
    getTrending();
    // _api.getTrending().then((value) {
    //   seriesPopulares = value;
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(context) {
    super.build(context);
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: seriesPopulares.isNotEmpty
          ? CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.02, bottom: width * 0.01),
                    child: const Text(
                      'Trending',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                _PopularList(items: seriesPopulares)
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Loading(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: LoadingFrases(loading: seriesPopulares.isEmpty),
                )
              ],
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _PopularList extends StatelessWidget {
  final List<Serie> items;
  _PopularList({required this.items});
  final double width = 150;
  final ApiService _api = ApiService();
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        Serie serie = items[index];
        return Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.blueGrey.shade700)),
          child: InkWell(
              onTap: () {
                _api.getSerie(serie.id!, 1).then(
                  (value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeriePage(serie: value),
                      ),
                    );
                  },
                );
              },
              child: CachedNetworkImage(
                imageUrl: _api.getSeriePoster(serie.poster!),
                errorWidget: (context, url, error) {
                  return const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Não foi possível carregar a imagem ;-;",
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, progress) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(serie.nome!,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center),
                    ],
                  );
                },
              )
              // Image.network(
              //   _api.getSeriePoster(items[index].poster!),
              //   fit: BoxFit.cover,
              //   width: width * 0.65,
              //   height: width,
              // ),
              ),
        );
      }, childCount: items.length),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          childAspectRatio: 0.7),
    );
  }
}
