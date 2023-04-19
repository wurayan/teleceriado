import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/serie_model.dart';

class ShowDetails extends StatefulWidget {
  final Serie serie;
  const ShowDetails({super.key, required this.serie});

  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  Serie? _serie;
  @override
  void initState() {
    _serie = widget.serie;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return 
    SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      _serie!.imagemUrl == null
                          ? const Center(
                              child: Text(
                                'Imagem não encontrada ;-;',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15)),
                              ),
                              width: width,
                              height: height * 0.2,
                              clipBehavior: Clip.hardEdge,
                              child: Image.network(_serie!.imagemUrl!,
                              fit: BoxFit.cover,),
                            ),
                      Text(_serie!.nome, style: const TextStyle(fontSize: 20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(_serie!.status)
                        ],
                      ),
                      Container(
                        color: Colors.cyanAccent,
                        height: height*0.2,
                        width: width,
                        child: Text(_serie!.descricao==null?'Sem descrição':_serie!.descricao!),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
