import 'package:flutter/material.dart';
import 'package:teleceriado/components/loading.dart';
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
  List<Usuario> seguindoList = [];
  int listLength = 0;
  bool loading = true;

  getSeguindo(List seguindo) async {
    listLength = seguindo.length < 20 ? seguindo.length : 20;
    seguindoList = widget.seguindo;
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    getSeguindo(widget.seguindo);
    super.initState();
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
          loading
              ? const Loading()
              : seguindoList.isEmpty
                  ? const Center(
                      child: Text(
                        "Você não segue ninguém ainda.\nQue tal começar por alguém da lista acima?",
                        textAlign: TextAlign.center,
                      ),
                    )
                  : SizedBox(
                      height: height * 0.2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: listLength,
                        itemBuilder: (context, index) {
                          return UsuarioItem(usuario: seguindoList[index]);
                        },
                      ),
                    )
        ],
      ),
    );
  }
}
