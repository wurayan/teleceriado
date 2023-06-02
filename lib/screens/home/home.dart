import 'package:flutter/material.dart';
import 'package:teleceriado/screens/first_page.dart';
import 'package:teleceriado/screens/home/widget/search.dart';
import 'package:teleceriado/screens/user_feed.dart';
import 'package:teleceriado/services/firebase_path.dart';
import 'package:teleceriado/services/user_dao/user_collections.dart';

import '../../models/colletion.dart';
import '../../services/auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService(); 

  List pages = [
    const FisrtPage(),
    const UserFeed(),
  ];
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teleceriado'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Search()
          )
        ],
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'FirstScreen'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border_outlined), label: 'UserScreen'),
        ],
        selectedItemColor: Colors.grey,
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: const Text('Log Out'),
            ),
            TextButton(
              onPressed: (){
                FirebaseCollections db = FirebaseCollections();
                Collection favoritos = Collection();
                favoritos.nome = "favoritos";
                favoritos.descricao = "primeira coleção";
                favoritos.imagem = "umaUrl"; 
                db.createCollection(favoritos);
              }, 
              child: const Text("Criar favoritos")),
            TextButton(
              onPressed: (){
                FirebaseCollections db = FirebaseCollections();
                Collection colecao = Collection();
                colecao.nome = "diabos";
                colecao.descricao = "segunda coleção";
                colecao.imagem = "outraUrl"; 
                db.createCollection(colecao);
              }, 
              child: const Text("Criar diabos")),
            TextButton(
              onPressed: (){
                FirebaseCollections db = FirebaseCollections();
                db.getAllCollections();
              },
              child: const Text("pega favoritos")
            ),
          ],
        ),
      ),
      body: 
      pages[_currentPage],
    );
  }
}
