import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/update_seguindo.dart';
import 'package:teleceriado/services/user_dao/firebase_export.dart';

import '../../../models/collection.dart';

class SeguirColecao extends StatefulWidget {
  final Collection colecao;
  const SeguirColecao({super.key, required this.colecao});

  @override
  State<SeguirColecao> createState() => _SeguirColecaoState();
}

class _SeguirColecaoState extends State<SeguirColecao> {
  final FirebaseComunidade _comunidade = FirebaseComunidade();
  bool? seguindo;

  isFollowing(Collection colecao) async {
    seguindo = await _comunidade.isFollowingColecao(colecao);
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    isFollowing(widget.colecao);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (seguindo == null) return;
        _comunidade.seguirColecao(widget.colecao, !seguindo!);
        seguindo = !seguindo!;
        Provider.of<UpdateSeguindo>(context, listen: false).update = true;
        setState(() {});
      },
      child: Text(seguindo ?? false ? "SEGUINDO" : "SEGUIR"),
    );
  }
}
