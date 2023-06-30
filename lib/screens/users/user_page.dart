import 'package:flutter/material.dart';
import 'package:teleceriado/screens/users/widgets/user_collections.dart';
import 'package:teleceriado/screens/users/widgets/user_details.dart';
import 'package:teleceriado/screens/users/widgets/user_header.dart';

import '../../models/usuario.dart';

class UserPage extends StatefulWidget {
  final Usuario usuario;
  const UserPage({super.key, required this.usuario});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool option = true;

  changeOption(){
    setState(() {
      option = !option;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: UserHeader(usuario: widget.usuario),
            ),
            UserDetails(usuario: widget.usuario),
            SliverToBoxAdapter(
              child: SizedBox(
                height: height * 0.05,
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        changeOption();
                      },
                      child: Text(
                        "Coleções: ",
                        style: TextStyle(
                          letterSpacing: 1,
                          color: option ? Colors.white : Colors.white54),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        changeOption();
                      },
                      child: Text(
                        "Comentários: ",
                        style: TextStyle(letterSpacing: 1,
                        color: !option ? Colors.white : Colors.white54),
                      ),
                    )
                  ],
                ),
              ),
            ),
            
            UserCollectionsList(usuario: widget.usuario),
          ],
        ),
      ),
    );
  }
}
