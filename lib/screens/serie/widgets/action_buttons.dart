import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:teleceriado/screens/serie/widgets/collection_list.dart';

import '../../../models/serie.dart';
import '../../../services/user_dao/user_collections.dart';

class ActionButtons extends StatelessWidget {
  final Serie serie;
  ActionButtons({super.key, required this.serie});
  final FirebaseCollections _collections = FirebaseCollections();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {
              _collections.saveInCollection("Favoritos", serie).then(
                    (value) => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.black,
                        content: Text("Série Favoritada!", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  );
            },
            style: TextButton.styleFrom(iconColor: Colors.grey),
            child: const Column(
              children: [
                Icon(Icons.favorite_border_rounded, size: 50),
                Text("Favoritar", style: TextStyle(color: Colors.grey))
              ],
            )),
        TextButton(
          onPressed: () async {
            List<String> collectionList =
                await _collections.getAllCollections();
            // ignore: use_build_context_synchronously
            String collectionId = await showDialog(
                context: context,
                builder: (context) => CollectionList(
                      collectionList: collectionList,
                    ));
            _collections.saveInCollection(collectionId, serie).then(
                  (value) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Série salva em $collectionId!"),
                    ),
                  ),
                );
          },
          style: TextButton.styleFrom(iconColor: Colors.grey),
          child: const Column(
            children: [
              Icon(Icons.bookmark_add_outlined, size: 50),
              Text("Salvar", style: TextStyle(color: Colors.grey))
            ],
          ),
        ),
      ],
    );
  }
}
