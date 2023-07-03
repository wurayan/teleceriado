import 'package:flutter/material.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/screens/components/custom_appbar.dart';
import 'package:teleceriado/screens/usuarios/widgets/colecoes_screen.dart';
import 'package:teleceriado/screens/usuarios/widgets/comentarios.dart';
import 'package:teleceriado/screens/usuarios/widgets/user_screen.dart';

import '../../models/collection.dart';
import '../../models/episodio.dart';
import '../../models/usuario.dart';

class UserPage extends StatefulWidget {
  final Usuario usuario;
  const UserPage({super.key, required this.usuario});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  int _currentPage = 1;
  // List<BottomNavigationBarItem>? bottomNavigationBarItens;
  List pages = [];

  getData() async {
    List<Episodio> episodios = [];
    List<Collection> colecoes = [];
    pages = [
      ColecoesScreen(colecoes: colecoes),
      ComentariosScreen(episodios: episodios),
      UserScreen(usuario: widget.usuario),
    ];
    setState(() {});
  }

  List<BottomNavigationBarItem> bottomBarItens() {
    return [
      BottomNavigationBarItem(
        label: _currentPage == 0 ? "Coleções" : "",
        icon: const Icon(Icons.bookmark_border_rounded),
      ),
      BottomNavigationBarItem(
        label: _currentPage == 1 ? "Comentários" : "",
        icon: const Icon(Icons.mode_comment_outlined),
      ),
      BottomNavigationBarItem(
        label: _currentPage == 2 ? "Perfil" : "",
        icon: const Icon(Icons.account_circle_outlined),
      ),
    ];
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomBarItens(),
        selectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(size: 30),
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
      body: SafeArea(
        child: Stack(
          children: [
            pages.isNotEmpty
                ? pages[_currentPage]
                : Padding(
                    padding: EdgeInsets.only(top: height * 0.4),
                    child: const Loading(),
                  ),
            const CustomAppbar()
          ],
        ),
      ),
    );
  }
}
