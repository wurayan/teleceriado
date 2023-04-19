import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:teleceriado/screens/show_details.dart';
import 'package:teleceriado/services/api_service.dart';

import '../models/serie_model.dart';

class SearchFeed extends StatefulWidget {
  const SearchFeed({super.key});

  @override
  State<SearchFeed> createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {
  final EpisodateService _db = EpisodateService();
  // Map<String, String> seriesPopulares = {};
  List<Serie> seriesPopulares = [];

  @override
  void initState() {
    _db.showDetailSerie(29560);
    _db.getAllPopularSeries().then((value) {
      seriesPopulares = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: seriesPopulares.isNotEmpty
          ? CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: Text(
                    'Mais Populares',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                _PopularList(items: seriesPopulares)
              ],
            )
          : const Center(
              child: CircularProgressIndicator(value: null),
            ),
    );
  }
}

class _PopularList extends StatelessWidget {
  final List<Serie> items;
  _PopularList({required this.items});
  final double width = 150;
  final EpisodateService _db = EpisodateService();
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.blueGrey.shade700)),
          child: InkWell(
            onTap: () {
              _db.showDetailSerie(items[index].id).then((value) {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowDetails(serie: value),
                ),
              );
              });
              
            },
            child: items[index].thumbUrl == 'https://static.episodate.com'
                ? Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        const Expanded(child: SizedBox()),
                        const Text(
                          'Imagem não encontrada\n;-;',
                          style: TextStyle(fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          items[index].nome,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  )
                : Image.network(
                    items[index].thumbUrl,
                    fit: BoxFit.cover,
                    width: width * 0.65,
                    height: width,
                  ),
          ),
        );
      }, childCount: 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          childAspectRatio: 0.7),
    );
  }
}
