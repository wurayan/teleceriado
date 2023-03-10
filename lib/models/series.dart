import 'package:flutter/material.dart';

class Series {
  final String id;
  final String nome;
  final Text descricao;
  final String? imagem;

  Series(
    this.id,
    this.nome,
    this.descricao,
    this.imagem
  );
}
