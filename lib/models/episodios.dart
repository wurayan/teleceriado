import 'package:flutter/material.dart';

class Episodios {
  final int id;
  final String nome;
  final String? imagem;
  final String descricao;
  final String serieId;

  Episodios(
    this.id,
    this.nome,
    this.imagem,
    this.descricao,
    this.serieId
  );
}