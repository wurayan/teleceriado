import 'package:flutter/material.dart';
import 'package:teleceriado/models/temporada.dart';

class Serie extends ChangeNotifier {
  int? _id;
  String? _nome;
  String? _descricao;
  String? _poster;
  List<dynamic>? _generos;
  String? _release;
  List<dynamic>? _pais;
  String? _backdrop;
  int? _temporadasqtde;
  int? _episodiosqtde;
  List<Temporada>? _temporadas;
  String? _status;

  int? get id => _id;
  String? get nome => _nome;
  String? get descricao => _descricao;
  String? get poster => _poster;
  List<dynamic>? get generos => _generos;
  String? get release => _release;
  List<dynamic>? get pais => _pais;
  String? get backdrop => _backdrop;
  int? get temporadasqtde => _temporadasqtde;
  int? get episodiosqtde => _episodiosqtde;
  List<Temporada>? get temporadas => _temporadas;
  String? get  status => _status;

  set id(int? value) => _id = value;
  set nome(String? value) => _nome = value;
  set descricao(String? value) => _descricao = value;
  set poster(String? value) => _poster = value;
  set generos(List<dynamic>? value) => _generos = value;
  set release(String? value) => _release = value;
  set pais(List<dynamic>? value) => _pais = value;
  set backdrop(String? value) => _backdrop = value;
  set temporadasqtde(int? value) => _temporadasqtde = value;
  set episodiosqtde(int? value) => _episodiosqtde = value;
  set temporadas (List<Temporada>? value) => _temporadas = value;
  set status (String? value) => _status = value;

  @override
  String toString() {
    return 'ID: $_id\nNome: $_nome\nDescrição: $_descricao';
  }
}
