import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/usuario.dart';
import 'package:teleceriado/screens/trending_feed.dart';
import 'package:teleceriado/screens/home/widget/drawer.dart';
import 'package:teleceriado/screens/home/widget/new_collection.dart';
import 'package:teleceriado/screens/home/widget/search.dart';
import 'package:teleceriado/screens/collections_feed.dart';
import 'package:teleceriado/services/user_dao/firebase_export.dart';

import '../../models/serie.dart';
import '../../services/api_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseUsers _users = FirebaseUsers();
  final ApiService _api = ApiService();
  Usuario? usuario;
  bool first = true;

  List pages = [
    const TrendingFeed(),
    const CollectionsFeed(),
  ];

  List icons = [const Search(), const NewCollection()];

  int _currentPage = 0;

  getUserdata() async {
    usuario = await _users.getUserdata();
    if(mounted)setState(() {});
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
    if (first&&usuario!=null) saveUserdata(context, usuario!);

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
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: const IconThemeData(size: 30),
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: _currentPage == 0 ? 'Séries' : ""),
          BottomNavigationBarItem(
              icon: const Icon(Icons.bookmark_rounded),
              label: _currentPage == 1 ? 'Coleções' : ""),
        ],
        selectedItemColor: Colors.white,
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
      drawer: HomeDrawer(),
      body: pages[_currentPage],
    );
  }
}
