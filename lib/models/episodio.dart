// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';

class Episodio extends ChangeNotifier {
  int? _id;
  int? _numero;
  String? _nome;
  String? _descricao;
  String? _imagem;

  int? get id => _id;
  int? get numero => _numero;
  String? get nome => _nome;
  String? get descricao => _descricao;
  String? get imagem => _imagem;

  set id(int? value) => _id = value;
  set numero(int? value) => _numero = value;
  set nome(String? value) => _nome = value;
  set descricao(String? value) => _descricao = value;
  set imagem(String? value) => _imagem = value;
}
