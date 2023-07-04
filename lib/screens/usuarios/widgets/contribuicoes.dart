import 'package:flutter/material.dart';

class ContribuicoesUsuario extends StatefulWidget {
  const ContribuicoesUsuario({super.key});

  @override
  State<ContribuicoesUsuario> createState() => _ContribuicoesUsuarioState();
}

class _ContribuicoesUsuarioState extends State<ContribuicoesUsuario> {
  int? contribuicoes;
  
  @override
  void initState() {
    //TODO PEGAR A QUANTIDADE DE ITENS EDITADOS
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Text(
      "Contribuiçõess: $contribuicoes",
      style: const TextStyle(
        fontSize: 14
      )
    );
  }
}