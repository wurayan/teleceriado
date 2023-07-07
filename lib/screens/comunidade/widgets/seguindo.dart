import 'package:flutter/material.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/models/error_handler.dart';
import 'package:teleceriado/screens/comunidade/widgets/user_item.dart';
import '../../../services/user_dao/firebase_export.dart';

class Seguindo extends StatefulWidget {
  final List<String> seguindo;
  const Seguindo({super.key, required this.seguindo});

  @override
  State<Seguindo> createState() => _SeguindoState();
}

class _SeguindoState extends State<Seguindo> {
  final FirebaseUsers _users = FirebaseUsers();
  List seguindoList = [];
  bool loading = true;

  getSeguindo(List seguindo) async {
    int qtde = seguindo.length < 20 ? seguindo.length : 20;
    for (var i = 0; i < qtde; i++) {
      seguindoList.add(await _users.getUserdata(userId: seguindo[i]));
    }
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
                        itemCount: seguindoList.length,
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