import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/usuario.dart';
import 'package:teleceriado/screens/comentarios_feed.dart/comentarios_feed.dart';
import 'package:teleceriado/screens/trending_feed/trending_feed.dart';
import 'package:teleceriado/screens/home/widget/drawer.dart';
import 'package:teleceriado/screens/trending_feed/widget/search.dart';
import 'package:teleceriado/services/user_dao/firebase_export.dart';

import '../../models/serie.dart';
import '../../services/api_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  final FirebaseUsers _users = FirebaseUsers();
  final ApiService _api = ApiService();
  Usuario? usuario;
  bool first = true;

  List pages = [
    const ComentariosFeed(),
    const TrendingFeed(),

    // const CollectionsFeed(),
  ];

  List icons = [null, const Search()];

  int _currentPage = 0;

  getUserdata() async {
    usuario = await _users.getUserdata();
    if (mounted) setState(() {});
  }

  saveUserdata(context, Usuario usuario) async {
    Usuario provider = Provider.of<Usuario>(context);
    provider.uid = usuario.uid;
    provider.username = usuario.username;
    provider.avatar = usuario.avatar;
    provider.bio = usuario.bio;
    provider.assistindoAgora = usuario.assistindoAgora;
    provider.seguidores = usuario.seguidores;
    provider.editados = usuario.editados;
    provider.seguidoresQtde = usuario.seguidoresQtde;
    provider.serieFavorita = usuario.serieFavorita;
    if (provider.serieFavorita != null || provider.assistindoAgora != null) {
      int id = provider.assistindoAgora ?? provider.serieFavorita!;
      Serie serie = await _api.getSerie(id, 1);
      if (serie.backdrop == null || serie.backdrop!.isEmpty) return;
      provider.header = _api.getSeriePoster(serie.backdrop!);
    }
    first = false;
    setState(() {});
  }

  @override
  void initState() {
    getUserdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (first && usuario != null) saveUserdata(context, usuario!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teleceriado'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 5),
              child: icons[_currentPage])
        ],
        centerTitle: true,
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        child: BottomNavigationBar(
          // selectedIconTheme: const IconThemeData(size: 30),
          // unselectedIconTheme: const IconThemeData(size: 30),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.mode_comment_outlined,
                  size: 27,
                ),
                activeIcon: Icon(
                  Icons.mode_comment,
                  size: 27,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 30,
                ),
                activeIcon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: ""),
          ],
          selectedItemColor: Colors.white,
          currentIndex: _currentPage,
          onTap: (index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
      ),
      drawer: HomeDrawer(),
      body: pages[_currentPage],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
