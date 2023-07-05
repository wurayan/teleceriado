import 'package:flutter/material.dart';
import 'package:teleceriado/models/snackbar.dart';
import 'package:teleceriado/services/user_dao/firebase_collections.dart';
import 'package:teleceriado/utils/utils.dart';

import '../../models/collection.dart';
import '../../models/serie.dart';
import '../../services/api_service.dart';

class CreateCollection extends StatelessWidget {
  final Serie? serie;
  CreateCollection({super.key, this.serie});

  final FirebaseCollections _collections = FirebaseCollections();
  final ApiService _api = ApiService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _imagemController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar nova Coleção"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: height * 0.03),
                child: const Text("Nome da Coleção:"),
              ),
              TextFormField(
                controller: _tituloController,
                keyboardType: TextInputType.text,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus!.unfocus(),
                validator: (value) => value == null || value.isEmpty
                    ? "Insira um nome para a Coleção."
                    : null,
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.02),
                child: const Text("Imagem"),
              ),
              TextFormField(
                controller: _imagemController,
                keyboardType: TextInputType.url,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus!.unfocus(),
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.02),
                child: const Text("Descrição:"),
              ),
              TextFormField(
                controller: _descricaoController,
                keyboardType: TextInputType.multiline,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus!.unfocus(),
                maxLines: 4,
                maxLength: 255,
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: width * 0.45,
                      height: height * 0.06,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          side: const BorderSide(
                            width: 2.5,
                            color: Colors.grey,
                          ),
                        ),
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.45,
                      height: height * 0.06,
                      child: OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _salvar().then((value) {
                              SnackbarGlobal.show(
                                  "Série salva em ${_tituloController.text}!");
                              Navigator.pop(context,true);
                            });
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          side: const BorderSide(
                            width: 2.5,
                            color: Colors.grey,
                          ),
                        ),
                        child: const Text(
                          "Salvar",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _salvar() async {
    String? imagemUrl = _imagemController.text.isNotEmpty
        ? _imagemController.text
        : serie?.poster!=null ?
        _api.getSeriePoster(serie!.poster!) 
        : loremPicsum;
    Collection collection = Collection();
    collection.nome = _tituloController.text;
    collection.imagem = imagemUrl;
    collection.descricao = _descricaoController.text;
    await _collections.createCollection(collection);
    return serie != null
        ? _collections.saveInCollection(collection.nome!, serie!)
        : true;
  }
}
