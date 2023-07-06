import 'package:flutter/material.dart';

import '../../../models/serie.dart';
import '../../../models/snackbar.dart';
import '../../../services/user_dao/firebase_collections.dart';

class FavoriteButton extends StatefulWidget {
  final Serie serie;
  const FavoriteButton({super.key, required this.serie});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  final FirebaseCollections _collections = FirebaseCollections();
  late Serie serie;
  bool isFavorite = false;

  checkFavorite(int serieId) async {
    isFavorite = await _collections.isFavorite(serieId);
    setState(() {});
  }

  @override
  void initState() {
    serie = widget.serie;
    checkFavorite(serie.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        isFavorite
            ? _collections
                .removeInCollection("Favoritos", serie)
                .then((value) => SnackbarGlobal.show("Série desfavoritada"))
            : _collections.saveInCollection("Favoritos", serie).then(
                  (value) => SnackbarGlobal.show("Série Favoritada!"),
                );
        isFavorite = !isFavorite;
        setState(() {});
      },
      style: TextButton.styleFrom(iconColor: Colors.grey),
      child: Column(
        children: [
          Icon(
              isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              size: 50),
          Text(
            isFavorite ? "Favoritado" : "Favoritar",
            style: const TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
