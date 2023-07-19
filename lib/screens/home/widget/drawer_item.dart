import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final Function navigate;
  final Icon icon;
  final String title;
  const DrawerItem({super.key, required this.navigate, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width; 
    return InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const Comunidade(),
                  //   ),
                  // );
                  navigate();
                },
                child: Container(
                  width: double.infinity,
                  height: height * 0.06,
                  // color: Colors.grey[700],
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.02, right: width * 0.04),
                        child:
                        icon 
                        // const Icon(Icons.view_carousel_rounded),
                      ),
                      Text(
                        // "Comunidade",
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}