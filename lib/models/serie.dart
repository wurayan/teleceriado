// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:teleceriado/models/temporada.dart';

class Serie extends ChangeNotifier {
  int? _id;
  String? _nome;
  String? _descricao;
  String? _poster;
  List<String>? _generos;
  String? _release;
  List<String>? _pais;
  String? _backdrop;
  int? _temporadasqtde;
  int? _episodiosqtde;
  List<Temporada>? _temporadas;
  String? _status;
  bool? _isFavorite;
  String? _link;
  bool? _situacao;
  List<String>? _emissoras;
  List<String>? _produtoras;

  int? get id => _id;
  String? get nome => _nome;
  String? get descricao => _descricao;
  String? get poster => _poster;
  List<String>? get generos => _generos;
  String? get release => _release;
  List<String>? get pais => _pais;
  String? get backdrop => _backdrop;
  int? get temporadasqtde => _temporadasqtde;
  int? get episodiosqtde => _episodiosqtde;
  List<Temporada>? get temporadas => _temporadas;
  String? get status => _status;
  bool? get isFavorite => _isFavorite;
  String? get link => _link;
  bool? get situacao => _situacao;
  List<String>? get emissoras => _emissoras;
  List<String>? get produtoras => _produtoras;

  set id(int? value) => _id = value;
  set nome(String? value) => _nome = value;
  set descricao(String? value) => _descricao = value;
  set poster(String? value) => _poster = value;
  set generos(List<String>? value) => _generos = value;
  set release(String? value) => _release = value;
  set pais(List<String>? value) => _pais = value;
  set backdrop(String? value) => _backdrop = value;
  set temporadasqtde(int? value) => _temporadasqtde = value;
  set episodiosqtde(int? value) => _episodiosqtde = value;
  set temporadas(List<Temporada>? value) => _temporadas = value;
  set status(String? value) => _status = value;
  set isFavorite(bool? value) => _isFavorite = value;
  set link(String? value) => _link = value;
  set situacao(bool? value) => _situacao = value;
  set emissoras(List<String>? value) => _emissoras = value;
  set produtoras(List<String>? value) => _produtoras = value;

  @override
  String toString() {
    return 'ID: $_id\nNome: $_nome\nDescrição: $_descricao';
  }

  Serie copyWith({
    int? id,
    String? nome,
    String? descricao,
    String? poster,
    List<String>? generos,
    String? release,
    List<String>? pais,
    String? backdrop,
    int? temporadasqtde,
    int? episodiosqtde,
    List<Temporada>? temporadas,
    String? status,
    String? link,
    bool? situacao,
    List<String>? emissoras,
    List<String>? produtoras,
  }) {
    Serie serie = Serie();
    serie.id = id ?? this.id;
    serie.nome = nome ?? this.nome;
    serie.descricao = descricao ?? this.descricao;
    serie.poster = poster ?? this.poster;
    serie.generos = generos ?? this.generos;
    serie.release = release ?? this.release;
    serie.pais = pais ?? this.pais;
    serie.backdrop = backdrop ?? this.backdrop;
    serie.temporadasqtde = temporadasqtde ?? this.temporadasqtde;
    serie.episodiosqtde = episodiosqtde ?? this.episodiosqtde;
    serie.temporadas = temporadas ?? this.temporadas;
    serie.status = status ?? this.status;
    serie.link = link ?? this.status;
    serie.situacao = situacao ?? this.situacao;
    serie.emissoras = emissoras  ?? this.emissoras;
    serie.produtoras = produtoras ?? this.produtoras;
    return serie;
  }
}
