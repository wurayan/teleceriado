import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../models/episodio.dart';

class ComentariosScreen extends StatelessWidget {
  final List<Episodio> episodios;
  const ComentariosScreen({super.key, required this.episodios});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if(details.primaryVelocity! > 0){
          print("swiped right");
        } else if (details.primaryVelocity! < 0) {
          print("swiped left");
        }
      },
      child: MasonryGridView.count( 
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4, 
        itemCount: containers.length,
        itemBuilder: (BuildContext context, int index) {
          return containers[index];
          },),
    );
  }
}

List<Widget> containers = [
  Container(
    height: 100,
    color: Colors.green,
  ),
  Container(
    height: 150,
    color: Colors.green,
  ),
  Container(
    height: 100,
    color: Colors.green,
  ),
  Container(
    height: 200,
    color: Colors.green,
  ),
  Container(
    height: 150,
    color: Colors.green,
  ),
  Container(
    height: 100,
    color: Colors.green,
  ),
  Container(
    height: 200,
    color: Colors.green,
  ),

];