import 'package:flutter/material.dart';
import 'package:teleceriado/models/error_handler.dart';

import '../../../models/usuario.dart';

class UserDetails extends StatelessWidget {
  final Usuario usuario;
  const UserDetails({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: height * 0.02),
                  child: SizedBox(
                    width: width * 0.8,
                    height: height * 0.1,
                    child: Text(
                      usuario.bio ??
                          "Essa pessoa não tem nada a falar sobre ela mesma",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.02, bottom: height * 0.01),
                      child: const Text("Contribuições: nada"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.03),
                      child: InkWell(
                        onTap: (){
                          ErrorHandler.show("  Esse botão ainda não faz nada...\n  Mas ele será útil no futuro, confia.");
                        },
                        child: const Icon(
                          Icons.star_border,
                          color: Colors.grey,
                          size: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: height * 0.01),
                  child: const Divider(
                    height: 1,
                    thickness: 0.5,
                    color: Colors.white24,
                  ),
                ),
              ],
            ),
          );
  }
}