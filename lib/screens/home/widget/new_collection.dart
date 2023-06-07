import 'package:flutter/material.dart';
import 'package:teleceriado/screens/collections/create_collection.dart';

class NewCollection extends StatelessWidget {
  const NewCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateCollection(),
          ),
        );
      },
      icon: const Icon(Icons.add_rounded, size: 35),
    );
  }
}
