import 'package:flutter/material.dart';
import 'package:teleceriado/models/snackbar.dart';
import 'package:teleceriado/screens/serie/widgets/collection_list.dart';

import '../../../models/collection.dart';
import '../../../models/serie.dart';
import '../../../services/user_dao/firebase_collections.dart';

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
                    (value) => SnackbarGlobal.show("Série Favoritada!")
                  );
            },
            style: TextButton.styleFrom(iconColor: Colors.grey),
            child: Column(
              children: [
                Icon(
                  // serie.isFavorite==true
                  // ? Icons.favorite_rounded
                  // : 
                  Icons.favorite_border_rounded, size: 50),
                Text(
                  // serie.isFavorite==true
                  // ?"Favoritado"
                  // :
                  "Favoritar", style: const TextStyle(color: Colors.grey))
              ],
            )),
        TextButton(
          onPressed: () async {
            List<Collection> collectionList =
                await _collections.getAllCollections();
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              builder: (context) => CollectionList(
                collectionList: collectionList,
                serie: serie,
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
