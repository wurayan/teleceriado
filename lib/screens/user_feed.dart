import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserFeed extends StatelessWidget {
  const UserFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
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