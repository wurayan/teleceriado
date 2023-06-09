import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/usuario.dart';
import 'package:teleceriado/screens/first_page.dart';
import 'package:teleceriado/screens/home/widget/drawer.dart';
import 'package:teleceriado/screens/home/widget/new_collection.dart';
import 'package:teleceriado/screens/home/widget/search.dart';
import 'package:teleceriado/screens/user_feed.dart';

import '../../services/user_dao/user_collections.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseCollections _collections = FirebaseCollections();

  List pages = [
    const FisrtPage(),
    const UserFeed(),
  ];

  List icons = [const Search(), const NewCollection()];

  int _currentPage = 0;
  String? username;

  getUsername() async {
    String user = await _collections.getUsername();
    setState(() {
      username = user;
    });
  }

  @override
  void initState() {
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    username!= null ? Provider.of<Usuario>(context).username = username : null;
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
