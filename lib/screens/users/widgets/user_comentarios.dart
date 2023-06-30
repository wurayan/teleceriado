import 'package:flutter/material.dart';

import '../../../models/serie.dart';
import '../../../services/api_service.dart';

class UserComentarios extends StatelessWidget {
  final List<Serie> series;
  const UserComentarios({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(childCount: series.length,
          (context, index) {
        Serie serie = series[index];
        return _SerieItem(serie: serie);
      }),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          childAspectRatio: 0.7),
    );
  }
}

class _SerieItem extends StatelessWidget {
  final Serie serie;
  _SerieItem({required this.serie});
  final ApiService _api = ApiService();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: 
      serie.poster!=null
      ? Image.network(
        _api.getSeriePoster(serie.poster!),
      )
      : Text(
        serie.nome!,
      ),
    );
  }
}