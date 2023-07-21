import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/update_seguindo.dart';

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
  int? seguidores;
  int? seguindo;

  getSeguidores(Usuario usuario) async {
    List<Usuario> lista = await _comunidade.getUsuariosSeguindo();
    seguindo = lista.length;
    Usuario profile = await _users.getUserdata(userId: usuario.uid!);
    seguidores = profile.seguidoresQtde;
    setState(() {});
  }

  updateSeguindo(context) async {
    await getSeguidores(widget.usuario);
    Provider.of<UpdateSeguindo>(context).update = false;
  }

  @override
  void initState() {
    getSeguidores(widget.usuario);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Consumer<UpdateSeguindo>(
      builder: (BuildContext context, value, Widget? child) {
        if(value.update==true) updateSeguindo(context);
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
      },
    );
  }
}
