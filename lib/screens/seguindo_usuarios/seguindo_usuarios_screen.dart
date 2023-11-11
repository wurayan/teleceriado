import 'package:flutter/material.dart';
import 'package:teleceriado/models/usuario.dart';
import 'package:teleceriado/screens/seguindo_usuarios/widget/seguindo_usuario_avatar.dart';

class SeguindoUsuariosScreen extends StatelessWidget {
  final List<Usuario> seguindo;
  const SeguindoUsuariosScreen({super.key, required this.seguindo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuários que você segue"),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 15),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                Usuario usuario = seguindo[index];
                return UsuarioAvatar(usuario: usuario);
              }, childCount: seguindo.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 3,
                mainAxisSpacing: 1,
                // childAspectRatio: 0.7
              ),
            ),
          ),
        ],
      ),
    );
  }
}
