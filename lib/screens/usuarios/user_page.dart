import 'package:flutter/material.dart';
import 'package:teleceriado/components/loading.dart';
import 'package:teleceriado/components/custom_appbar.dart';
import 'package:teleceriado/screens/usuarios/widgets/colecoes_screen.dart';
import 'package:teleceriado/screens/usuarios/widgets/comentarios.dart';
import 'package:teleceriado/screens/usuarios/widgets/user_screen.dart';
import 'package:teleceriado/services/user_dao/firebase_export.dart';
import '../../models/badge.dart';
import '../../models/collection.dart';
import '../../models/episodio.dart';
import '../../models/serie.dart';
import '../../models/usuario.dart';
import '../../services/api_service.dart';

class UserPage extends StatefulWidget {
  final Usuario usuario;
  const UserPage({super.key, required this.usuario});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final FirebaseCollections _collection = FirebaseCollections();
  final FirebaseEpisodios _episodios = FirebaseEpisodios();
  final FirebaseUsers _users = FirebaseUsers();
  final ApiService _api = ApiService();
  int _currentPage = 1;
  // List<BottomNavigationBarItem>? bottomNavigationBarItens;
  List pages = [];

  swipe(bool value) {
    if (value) {
      if (_currentPage > 0) {
        _currentPage -= 1;
        setState(() {});
      }
    } else {
      if (_currentPage < 2) {
        _currentPage += 1;
        setState(() {});
      }
    }
  }

  getData() async {
    String userId = widget.usuario.uid!;
    List<Episodio> episodios =
        await _episodios.getAllEditedEpisodios(userId);
    List<Collection> colecoes =
        await _collection.getAllCollections(user: userId);
    Usuario usuario = await _users.getUserdata(userId: userId);
    List<UserBadge> badges = await _users.getBadges(userId: userId);
    usuario.badges = badges;
    if(usuario.assistindoAgora!=null||usuario.serieFavorita!=null){
      int id =usuario.assistindoAgora??usuario.serieFavorita!;
      Serie serie = await _api.getSerie(id, 1);
      usuario.header = serie.backdrop!=null&&serie.backdrop!.isNotEmpty ? _api.getSeriePoster(serie.backdrop!) : null;
    }
    pages = [
      ColecoesScreen(
        colecoes: colecoes,
      ),
      ComentariosScreen(
        episodios: episodios,
      ),
      UserScreen(
        usuario: usuario,
      ),
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
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          swipe(true);
        } else if (details.primaryVelocity! < 0) {
          swipe(false);
        }
      },
      child: Scaffold(
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
                  : const Loading(),
              const CustomAppbar()
            ],
          ),
        ),
      ),
    );
  }
}
