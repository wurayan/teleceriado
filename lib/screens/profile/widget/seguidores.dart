import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/usuario.dart';
import '../../../services/user_dao/firebase_export.dart';

class SeguidoresCounter extends StatefulWidget {
  final Usuario usuario;
  const SeguidoresCounter({super.key, required this.usuario});

  @override
  State<SeguidoresCounter> createState() => _SeguidoresCounterState();
}

class _SeguidoresCounterState extends State<SeguidoresCounter> {
  final FirebaseComunidade _comunidade = FirebaseComunidade();
  final FirebaseUsers _users = FirebaseUsers();
  Usuario? profile;
  int? seguidores;
  int? seguindo;

  getSeguidores(Usuario usuario) async {
    List<Usuario> lista = await _comunidade.getUsuariosSeguindo();
    seguindo = lista.length;
    profile = await _users.getUserdata(userId: usuario.uid!);
    setState(() {});
  }

  updateUser(context) async {
    await Future.delayed(const Duration(seconds: 1));
    if (profile != null &&
        profile?.seguidoresQtde !=
            Provider.of<Usuario>(context, listen: false).seguidoresQtde) {
      Provider.of<Usuario>(context, listen: false).seguidores = profile?.seguidores;
      Provider.of<Usuario>(context, listen: false).seguidoresQtde = profile?.seguidoresQtde;
      Provider.of<Usuario>(context, listen: false).editados = profile?.editados;
      setState(() {});
    }
  }

  @override
  void initState() {
    getSeguidores(widget.usuario);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    updateUser(context);
    final double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Seguidores: ${seguidores ?? 0}",
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(
          width: width * 0.05,
        ),
        Text(
          "Seguindo: ${seguindo ?? 0}",
          style: const TextStyle(fontSize: 14),
        )
      ],
    );
  }
}
