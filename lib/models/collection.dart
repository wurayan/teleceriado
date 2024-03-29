// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/foundation.dart';
import 'package:teleceriado/models/serie.dart';

class Collection extends ChangeNotifier {
  String? _nome;
  String? _descricao;
  List<Serie>? _series;
  String? _imagem;
  String? _dono;
  int? _seguidoresQtde;

  String? get nome => _nome;
  String? get descricao => _descricao;
  List<Serie>? get series => _series;
  String? get imagem => _imagem;
  String? get dono => _dono;
  int? get seguidoresQtde => _seguidoresQtde;

  set nome(String? value) => _nome = value;
  set descricao(String? value) => _descricao = value;
  set series(List<Serie>? value) => _series = value;
  set imagem(String? value) => _imagem = value;
  set dono(String? value) => _dono = value;
  set seguidoresQtde (int? value) => _seguidoresQtde=value;

  @override
  String toString() {
    return "Nome: $nome\nDescricao: $descricao";
  }

  Map<String, dynamic> toMap() {
    return {"nome": nome, "descricao": descricao, "imagemUrl": imagem};
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
