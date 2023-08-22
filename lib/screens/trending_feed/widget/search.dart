import 'package:flutter/material.dart';

import '../../search_feed.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SearchFeed()));
      },
      icon: const Icon(
        Icons.search_rounded,
        size: 35,
      ),
    );
  }
}
