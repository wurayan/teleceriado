import 'package:flutter/material.dart';
import 'package:teleceriado/screens/first_page.dart';
import 'package:teleceriado/screens/home/widget/search.dart';
import 'package:teleceriado/screens/user_feed.dart';

import '../search_feed.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List pages = [
    const FisrtPage(),
    const UserFeed(),
  ];
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'SearchFeed'),
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
      body: 
      pages[_currentPage],
    );
  }
}
