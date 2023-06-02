import 'package:flutter/material.dart';
import 'package:teleceriado/screens/serie/widgets/action_buttons.dart';
import 'package:teleceriado/services/api_service.dart';

import '../../../models/serie.dart';

class SerieHeader extends StatelessWidget {
  final Serie serie;
  SerieHeader({super.key, required this.serie});
  final ApiService _api = ApiService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          ),
          width: width,
          height: height * 0.25,
          clipBehavior: Clip.hardEdge,
          child: Image.network(
            _api.getSeriePoster(serie.backdrop!),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        Column(
          children: [
            Container(
              height: height * 0.25,
              width: width,
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.grey.shade900])),
              child: Padding(
                padding:
                    EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      serie.nome!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.02),
              child: SizedBox(
                height: height * 0.1,
                width: width,
                child: Text(
                  serie.descricao == null ? 'Sem descrição' : serie.descricao!,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            ActionButtons(serie: serie),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
              child: const Divider(
                color: Colors.black54,
                thickness: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        // left: width * 0.02,
                        bottom: height * 0.01),
                    child: const Text(
                      'Episódios',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.01),
                  child: const Text('Detalhes', style: TextStyle(fontSize: 18)),
                )
              ],
            ),
          ],
        ),
        // CircleAvatar(
        //   backgroundColor: Colors.black54,
        //   radius: width * 0.05,
        //   child: const Icon(Icons.favorite_border_rounded),
        // )
      ],
    );

    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Stack(
    //       children: [
    //         Container(
    //                 decoration: const BoxDecoration(
    //                   borderRadius:
    //                       BorderRadius.vertical(top: Radius.circular(15)),
    //                 ),
    //                 width: width,
    //                 height: height * 0.2,
    //                 clipBehavior: Clip.hardEdge,
    //                 child: Image.network(
    //                   _api.getSeriePoster(serie.backdrop!),
    //                   fit: BoxFit.cover,
    //                   alignment: Alignment.topCenter,
    //                 ),
    //               ),
    //         Container(
    //           height: height*0.2,
    //           width: width,
    //           alignment: Alignment.bottomLeft,
    //           decoration: BoxDecoration(
    //                     gradient: LinearGradient(
    //                         begin: Alignment.topCenter,
    //                         end: Alignment.bottomCenter,
    //                         colors: [
    //                       Colors.transparent,
    //                       Colors.grey.shade900
    //                     ])),
    //           child: Padding(
    //             padding: EdgeInsets.only(left: width*0.02),
    //             child: Text(
    //               serie.nome!,
    //               style:
    //                   const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     Padding(
    //       padding: EdgeInsets.all(width * 0.02),
    //       child: SizedBox(
    //         height: height * 0.1,
    //         width: width,
    //         child: Text(
    //           serie.descricao == null ? 'Sem descrição' : serie.descricao!,
    //           maxLines: 5,
    //           overflow: TextOverflow.ellipsis,
    //         ),
    //       ),
    //     ),
    //     Padding(
    //       padding: EdgeInsets.symmetric(vertical: height * 0.01),
    //       child: const Divider(
    //         color: Colors.black54,
    //         thickness: 1,
    //       ),
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         Container(
    //           decoration: const BoxDecoration(
    //             borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    //           ),
    //           child: Padding(
    //             padding: EdgeInsets.only(
    //                 // left: width * 0.02,
    //                 bottom: height * 0.01),
    //             child: const Text(
    //               'Episódios',
    //               style: TextStyle(fontSize: 18),
    //             ),
    //           ),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(bottom: height * 0.01),
    //           child: const Text('Detalhes', style: TextStyle(fontSize: 18)),
    //         )
    //       ],
    //     ),
    //   ],
    // );
  }
}
