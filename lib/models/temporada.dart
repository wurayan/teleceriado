// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';

import 'episodio.dart';

class Temporada extends ChangeNotifier {
  int? _id;
  int? _numero;
  String? _descricao;
  int? _episodiosqtde;
  String? _poster;
  List<Episodio>? _episodios;

int? get  id => _id;
int? get  numero => _numero;
String? get  descricao => _descricao;
int? get  episodiosqtde => _episodiosqtde;
String? get  poster => _poster;
List<Episodio>? get episodios => _episodios;

set id (int?   value) => _id = value;
set numero (int?   value) => _numero = value;
set descricao (String?   value) => _descricao = value;
set episodiosqtde (int?   value) => _episodiosqtde = value;
set poster (String?   value) => _poster = value;
set episodios (List<Episodio>?   value) => _episodios = value;
}