import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teleceriado/models/update_seguindo.dart';
import '../../../models/collection.dart';
import '../../../services/user_dao/firebase_export.dart';

class ColecaoSeguidores extends StatefulWidget {
  final Collection colecao;
  const ColecaoSeguidores({super.key, required this.colecao});

  @override
  State<ColecaoSeguidores> createState() => _CoelcaoleguidoresState();
}

class _CoelcaoleguidoresState extends State<ColecaoSeguidores> {
  final FirebaseCollections _collections = FirebaseCollections();
  Collection dados = Collection();

  getSeguidores(Collection colecao) async {
    
    dados = await _collections.getCollectionInfo(colecao.nome!,
        userId: colecao.dono!); 
    if (mounted) setState(() {});
  }

  update(context) async {
    await Future.delayed(const Duration(seconds: 1));
    await getSeguidores(widget.colecao);
    
    Provider.of<UpdateSeguindo>(context, listen: false).update = false;
  }

  @override
  void initState() {
    getSeguidores(widget.colecao);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateSeguindo>(
      builder: (context, value, child) {
        if (value.update == true) update(context);
        return Text(
          "Seguidores: ${dados.seguidoresQtde ?? 0}",
        );
      },
    );
  }
}
