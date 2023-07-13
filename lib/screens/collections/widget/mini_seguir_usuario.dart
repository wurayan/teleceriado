import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/update_seguindo.dart';
import 'package:teleceriado/screens/comunidade/comunidade.dart';
import 'package:teleceriado/services/user_dao/firebase_comunidade.dart';

import '../../../models/usuario.dart';

class MiniSeguirUsuario extends StatefulWidget {
  final Usuario usuario;
  const MiniSeguirUsuario({super.key, required this.usuario});

  @override
  State<MiniSeguirUsuario> createState() => _MiniSeguirUsuarioState();
}

class _MiniSeguirUsuarioState extends State<MiniSeguirUsuario> {
  final FirebaseComunidade _comunidade = FirebaseComunidade();

  bool? isFollowing;

  check() async {
    isFollowing = await _comunidade.isFollowingUsuario(widget.usuario.uid!);
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isFollowing == null
        ? const SizedBox()
        : Visibility(
            visible: !isFollowing!,
            child: TextButton(
              onPressed: () {
                _comunidade.seguirUsuario(widget.usuario, !isFollowing!);
                isFollowing = !isFollowing!;
                Provider.of<UpdateSeguindo>(context, listen: false).update = true;
                setState(() {});
              },
              child: const Text(
                "SEGUIR",
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          );
  }
}
