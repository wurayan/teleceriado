import 'package:flutter/material.dart';

class UserFeed extends StatelessWidget {
  const UserFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Text('Favoritos:'),
        ),
        // SliverList(delegate: 
        // SliverChildBuilderDelegate(
        //   childCount: 10,
        //   (context, index) {
        //     return 
        //   } ))
      ],
    );
  }
}