import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/screens/serie/serie_details.dart';
import 'package:teleceriado/services/api_service.dart';
import 'package:teleceriado/utils/utils.dart';
import '../models/serie.dart';

class FisrtPage extends StatefulWidget {
  const FisrtPage({super.key});

  @override
  State<FisrtPage> createState() => _FisrtPageState();
}

class _FisrtPageState extends State<FisrtPage> with  AutomaticKeepAliveClientMixin{
  final ApiService _api = ApiService();
  List<Serie> seriesPopulares = [];
  String loadingFrase = getLoadingFrase();

  @override
  void initState() {
    _api.getTrending().then((value) {
      seriesPopulares = value;
      setState(() {});
    });
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (seriesPopulares.isEmpty) {
        setState(() {
          loadingFrase = getLoadingFrase();
        });
      } else {
        timer.cancel();
      }
    });
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
                child: Text(loadingFrase, style: const TextStyle(fontSize: 18),),
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
        return Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.blueGrey.shade700)),
          child: InkWell(
            onTap: () {
              _api.getSerie(items[index].id!, 1).then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowDetails(serie: value),
                  ),
                );
              });
            },
            child: Image.network(
              _api.getSeriePoster(items[index].poster!),
              fit: BoxFit.cover,
              width: width * 0.65,
              height: width,
            ),
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
