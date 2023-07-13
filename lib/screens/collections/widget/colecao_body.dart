import 'package:flutter/material.dart';

import '../../../models/serie.dart';
import '../../../services/api_service.dart';
import '../../serie/serie_details.dart';

class Body extends StatelessWidget {
  final List<Serie> series;
  Body({super.key, required this.series});

  final ApiService _api = ApiService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return SliverPadding(
      padding: const EdgeInsets.only(left: 3, top: 3, right: 3),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            Serie serie = series[index];
            return Container(
              decoration: BoxDecoration(
                  border:
                      Border.all(width: 0.5, color: Colors.blueGrey.shade700)),
              child: InkWell(
                onTap: () {
                  _api.getSerie(serie.id!, 1).then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowDetails(serie: value),
                      ),
                    );
                  });
                },
                child: Image.network(
                  _api.getSeriePoster(serie.poster!),
                  fit: BoxFit.cover,
                  width: width * 0.65,
                  height: width,
                ),
              ),
            );
          },
          childCount: series.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            childAspectRatio: 0.7),
      ),
    );
  }
}
