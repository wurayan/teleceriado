import 'package:flutter/material.dart';
import 'package:teleceriado/screens/comunidade/widgets/user_item.dart';

import '../../../models/usuario.dart';

class TopUsers extends StatelessWidget {
  final List<Usuario>? usuarios;
  const TopUsers({super.key, required this.usuarios});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.02, left: width * 0.02),
            child: const Text(
              "Top Contribuintes",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1),
            ),
          ),
          usuarios == null || usuarios!.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: height * 0.05),
                  child: const Center(
                    child: Text(
                      "(◞‸◟) É triste estar sozinho né...",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: height * 0.01),
                  child: SizedBox(
                    height: height * 0.17,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: usuarios!.length,
                      itemBuilder: (context, index) {
                        return UsuarioItem(
                          usuario: usuarios![index],
                        );
                      },
                    ),
                  ),
                )
        ],
      ),
    );
  }
}