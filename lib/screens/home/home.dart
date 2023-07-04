import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/usuario.dart';
import 'package:teleceriado/screens/trending_feed.dart';
import 'package:teleceriado/screens/home/widget/drawer.dart';
import 'package:teleceriado/screens/home/widget/new_collection.dart';
import 'package:teleceriado/screens/home/widget/search.dart';
import 'package:teleceriado/screens/collections_feed.dart';
import '../../services/user_dao/firebase_collections.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseCollections _collections = FirebaseCollections();
  Usuario? usuario;

  List pages = [
    const TrendingFeed(),
    const CollectionsFeed(),
  ];

  List icons = [const Search(), const NewCollection()];

  int _currentPage = 0;

  getUserdata() async {
    usuario = await _collections.getUserdata();
    setState(() {});
  }

  saveUserdata(context, Usuario usuario) {
    Usuario provider = Provider.of<Usuario>(context);
    provider.uid = usuario.uid;
    provider.username = usuario.username;
    provider.avatar = usuario.avatar;
    setState(() {});
  }

  @override
  void initState() {
    getUserdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (usuario != null) {
      saveUserdata(context, usuario!);
    }
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
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'FirstScreen'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_rounded), label: 'UserScreen'),
        ],
        selectedItemColor: Colors.grey,
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
