import 'package:flutter/material.dart';
import 'package:teleceriado/models/error_handler.dart';
import 'package:teleceriado/models/usuario.dart';
import 'package:teleceriado/screens/comunidade/widgets/user_item.dart';

class SeguindoUsuarios extends StatefulWidget {
  final List<Usuario> seguindo;
  const SeguindoUsuarios({super.key, required this.seguindo});

  @override
  State<SeguindoUsuarios> createState() => _SeguindoState();
}

class _SeguindoState extends State<SeguindoUsuarios> {

  int length(List<Usuario> seguindo) {
    return seguindo.length<20?seguindo.length:20;
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.02),
                child: const Text(
                  "Usuarios que segue:",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1),
                ),
              ),
              TextButton(
                onPressed: () {
                  ErrorHandler.show("Ainda não faz nada.");
                },
                child: const Text(
                  "MAIS",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          widget.seguindo.isEmpty
                  ? SizedBox(
                    height: height*0.1,
                    child: const Center(
                        child: Text(
                          "Você não segue ninguém ainda.\nQue tal começar por alguém da lista acima?",
                          textAlign: TextAlign.center,
                        ),
                      ),
                  )
                  : SizedBox(
                      height: height * 0.15,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: length(widget.seguindo),
                        itemBuilder: (context, index) {
                          return UsuarioItem(usuario: widget.seguindo[index]);
                        },
                      ),
                    )
        ],
      ),
    );
  }
}
