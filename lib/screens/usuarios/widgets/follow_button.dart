import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/update_seguindo.dart';
import 'package:teleceriado/services/user_dao/firebase_export.dart';

import '../../../models/usuario.dart';

class BotaoSeguindo extends StatefulWidget {
  final Usuario usuario;
  const BotaoSeguindo({super.key, required this.usuario});

  @override
  State<BotaoSeguindo> createState() => _BotaoSeguindoState();
}

class _BotaoSeguindoState extends State<BotaoSeguindo> {
  final FirebaseComunidade _comunidade = FirebaseComunidade();
  bool? seguindo;

  isFollowing(String usuarioId) async {
    seguindo = await _comunidade.isFollowingUsuario(usuarioId);
    setState(() {});
  }

  @override
  void initState() {
    isFollowing(widget.usuario.uid!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (seguindo==null) return;
        _comunidade.seguirUsuario(widget.usuario, !seguindo!);
        seguindo = !seguindo!;
        Provider.of<UpdateSeguindo>(context, listen: false).update=true;
        setState(() {});
      },
      child: Text(seguindo??false ? "SEGUINDO" : "SEGUIR",
      style: const TextStyle(
        fontSize: 14,
        height: 0.8
      )),
    );
    
    // OutlinedButton(
    //   onPressed: () {
    //     if (seguindo==null) return;
    //     _comunidade.seguirUsuario(widget.usuario, !seguindo!);
    //     seguindo = !seguindo!;
    //     Provider.of<UpdateSeguindo>(context, listen: false).update=true;
    //     setState(() {});
    //   },
    //   child: Text(seguindo??false ? "SEGUINDO" : "SEGUIR"),
    // );
  }
}
