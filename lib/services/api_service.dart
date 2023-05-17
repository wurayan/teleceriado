import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teleceriado/services/web_client.dart';

import '../models/serie_model.dart';

class EpisodateService {
  String url = WebClient.url;
  http.Client client = WebClient().client;

  static const String getPopular = 'most-popular?';

  Uri getUri(String endpoint) {
    return Uri.parse('$url$endpoint');
  }

  Future<List<Serie>> getAllPopularSeries() async {
    List<Serie> result = [];
    for (var i = 1; i <= 5; i++) {
      http.Response response = await client.get(getUri('${getPopular}page=$i'));
      if (response.statusCode != 200) {
        throw HttpException(response.body);
      }

      Map resultMap = json.decode(response.body);

      // List<dynamic> listDynamic = json.decode(response.body);
      for (var map in resultMap['tv_shows']) {
        result.add(Serie.fromMap(map));
      }
    }
    return result;
  }

  Future<Serie> showDetailSerie(int id) async {
    http.Response response = await client.get(getUri('show-details?q=$id'));
    if (response.statusCode != 200) {
        throw HttpException(response.body);
      }

      Map resultMap = json.decode(response.body);
      return Serie.fromMap(resultMap['tvShow']);
  }

  
}
