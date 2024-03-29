import 'dart:async';
import 'dart:convert';
import 'dart:math';

// import 'package:teleceriado/services/user_dao/firebase_collections.dart';
import 'package:teleceriado/services/web_client.dart';
import 'package:http/http.dart' as http;

import '../models/episodio.dart';
import '../models/serie.dart';
import '../models/temporada.dart';

class ApiService {
  // final FirebaseCollections _collections = FirebaseCollections();
  String url = WebClient.url;
  http.Client client = WebClient().client;

  static const String weekTrending = "trending/tv/week?language=pt-Br";
  static const String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzOThiNTViY2UzZGRhZDE3MmU0YWY2MGE0OTM2ZWQ0MCIsInN1YiI6IjY0NjYwZGU1ZDE4NTcyMDBlNWEyZDBiZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XIf1WbVnJXN9ca838DTr53b0tMYnWng9MJasE6CtH90";

  static const String posterPrefix = "https://image.tmdb.org/t/p/w342";
  Map<String, String> header = {"Authorization": "Bearer $token"};

  Uri getUri(String endPoint) {
    return Uri.parse('$url$endPoint');
  }

  String getSeriePoster(String poster) {
    return '$posterPrefix$poster';
  }

  Future<String> getRandomBackdrop() async {
    List<dynamic> results = [];

    http.Response response =
        await client.get(getUri("tv/latest"), headers: header);
    Map body = json.decode(response.body);
    while (results.isEmpty) {
      int random = Random().nextInt(body["id"]);
      response = await client.get(getUri("tv/$random/images"), headers: header);
      if (response.statusCode == 200) {
        Map map = json.decode(response.body);
        results = map["backdrops"];
      }
    }
    return getSeriePoster(results[0]["file_path"]);
  }

  Future<List<Serie>> getTrending() async {
    List<Serie> trending = [];
    for (var i = 1; i < 5; i++) {
      http.Response response = await client.get(getUri('$weekTrending&page=$i'),
          headers: {"Authorization": "Bearer $token"});
      Map body = json.decode(response.body);
      List<dynamic> resultados = body['results'];
      trending.addAll(toList(resultados));
    }
    return trending;
    // return toList(resultados);
  }

  Future<List<Serie>> searchSerie(String value) async {
    // search/tv?query=game&language=pt-BR&page=1
    String query = value.replaceAll(' ', ',');
    http.Response response = await client.get(
        getUri("search/tv?query=$query&language=pt-BR&page=1"),
        headers: {"Authorization": "Bearer $token"});
    Map body = json.decode(response.body);
    List<dynamic> resultados = body['results'];
    return toList(resultados);
  }

  Future<Serie> getSerie(int id, int temporada) async {
    http.Response response = await client.get(
        getUri("tv/$id?append_to_response=season%2F$temporada&language=pt-BR"),
        headers: {"Authorization": "Bearer $token"});
    Map body = json.decode(response.body);
    // List<dynamic> resultados = body['results'];
    // bool isFavorite = await _collections.isFavorite(id);
    return toSerie(body, temporada);
  }

  Future<List<Episodio>> getEpisodios(int idSerie, int temporada) async {
    http.Response response = await client.get(
        getUri("tv/$idSerie/season/$temporada?language=pt-BR"),
        headers: {"Authorization": "Bearer $token"});
    Map body = json.decode(response.body);
    List<dynamic> resultados = body['episodes'];
    response =
        await client.get(getUri("tv/$idSerie?language=pt-BR"), headers: header);
    Map map = json.decode(response.body);
    String serie = map["name"];
    return episodiosToList(resultados, serie);
  }

  getOnlyEpisodio(Episodio episodio) async {
    http.Response response = await client.get(
      getUri("tv/${episodio.serieId}/season/${episodio.temporada}/episode/${episodio.numero}?language=pt-BR"),
      headers: header
    );
    Serie serie = await getSerie(episodio.serieId!, episodio.temporada!);
    // tv/114472/season/1/episode/1?language=pt-BR
    Map body = json.decode(response.body);
    return episodiosToList([body], serie.nome!).first;
  }

  Serie toSerie(Map resultado, int value) {
    Serie serie = Serie();
    serie.id = resultado['id'];
    serie.backdrop = resultado['backdrop_path'];
    serie.generos = getData(resultado["genres"]);
    serie.nome = resultado['name'];
    serie.episodiosqtde = resultado['number_of_episodes'];
    serie.temporadasqtde = resultado['number_of_seasons'];
    serie.descricao = resultado['overview'];
    serie.poster = resultado['poster_path'];
    serie.status = resultado['status'];
    serie.temporadas = getTemporada(resultado['seasons']);
    serie.release = resultado["first_air_date"];
    serie.link = resultado["homepage"];
    serie.situacao = resultado["in_production"];
    serie.emissoras = getData(resultado["networks"]);
    serie.produtoras = getData(resultado["production_companies"]);
    List<dynamic> originCountry = resultado["origin_country"];
    serie.pais = originCountry.map((e) => e.toString()).toList();
    return serie;
  }

  List<Temporada> getTemporada(List<dynamic> value) {
    List<Temporada> temporadas = [];
    for (Map temporadaDetails in value) {
      Temporada temporada = Temporada();
      temporada.id = temporadaDetails['id'];
      temporada.numero = temporadaDetails['season_number'];
      temporada.poster = temporadaDetails['poster_path'];
      temporada.episodiosqtde = temporadaDetails['episode_count'];
      temporada.descricao = temporadaDetails['overview'];
      // temporada.episodios = getEpisodios(episodios);
    }
    return temporadas;
  }

  List<String> getData(List<dynamic> value) {
    List<String> lista = [];
    for (Map map in value) {
      lista.add(map["name"]);
    }
    return lista;
  }

  List<Episodio> episodiosToList(List<dynamic> value, String serie) {
    List<Episodio> episodios = [];
    for (Map episodioDetails in value) {
      Episodio episodio = Episodio();
      episodio.id = episodioDetails['id'];
      episodio.numero = episodioDetails['episode_number'];
      episodio.nome = episodioDetails['name'];
      episodio.imagem = episodioDetails['still_path'];
      episodio.descricao = episodioDetails['overview'];
      episodio.serie = serie;
      episodio.serieId = episodioDetails['show_id'];
      episodio.temporada = episodioDetails['season_number'];
      episodios.add(episodio);
    }
    return episodios;
  }

  List<Serie> toList(List<dynamic> resultados) {
    List<Serie> series = [];
    for (Map serieDetails in resultados) {
      Serie serie = Serie();
      serie.id = serieDetails['id'];
      serie.nome = serieDetails['name'];
      // serie.pais = serieDetails['origin_country'];
      serie.poster = serieDetails['poster_path'];
      // serie.release = serieDetails['first_air_date'];
      // serie.descricao = serieDetails['overview'];
      // serie.generos = serieDetails['genre_ids'];
      serie.backdrop = serieDetails['backdrop_path'];
      series.add(serie);
    }
    return series;
  }
}
