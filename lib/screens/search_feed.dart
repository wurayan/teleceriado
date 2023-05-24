import 'package:flutter/material.dart';

class SearchFeed extends StatefulWidget {
  const SearchFeed({super.key});

  @override
  State<SearchFeed> createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {
  final TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _searchController,
          
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            color: Colors.amber,
          )
        ],
      )
    );
  }
}