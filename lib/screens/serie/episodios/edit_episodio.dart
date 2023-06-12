import 'package:flutter/material.dart';
import 'package:teleceriado/models/snackbar.dart';
import 'package:teleceriado/utils/decoration.dart';
import 'package:teleceriado/utils/utils.dart';

import '../../../models/episodio.dart';
import '../../../services/user_dao/user_collections.dart';

class EditEpisodio extends StatelessWidget {
  final Episodio episodio;
  final VoidCallback reload;
  EditEpisodio({super.key, required this.episodio, required this.reload});

  final FirebaseCollections _collection = FirebaseCollections();

  final TextEditingController _imagemController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.05, vertical: height * 0.02),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Link da Imagem:",
            style: TextStyle(fontSize: 14),
          ),
          TextFormField(
            controller: _imagemController,
            keyboardType: TextInputType.url,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus!.unfocus(),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.01),
            child: const Text(
              "Sua descrição:",
              style: TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(
              height: height * 0.15,
              width: width * 0.8,
              child: TextFormField(
                controller: _descricaoController,
                keyboardType: TextInputType.multiline,
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus!.unfocus(),
                expands: true,
                minLines: null,
                maxLines: null,
                maxLength: 144,
                decoration: episodioDescricaoFormfield,
              )),
          Padding(
            padding: EdgeInsets.only(top: height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: width * 0.3,
                  height: height * 0.05,
                  child: ElevatedButton(
                    onPressed: () {
                      reload();
                    },
                    child: const Text("Cancelar"),
                  ),
                ),
                SizedBox(
                  width: width * 0.3,
                  height: height * 0.05,
                  child: ElevatedButton(
                    onPressed: () async {
                      //TODO PARANDO PARA PENSAR, SE EU VOU SALVAR OS DOIS PARAMETROS DEPOIS DE QUALQUER MODO, EU NÃO PRECISO VERIFICAR NADA ALEM DA VALIDADE DO LINK
                      if (_imagemController.text.isNotEmpty ||
                          _descricaoController.text.isNotEmpty) {
                        Episodio newEpisodio = Episodio();
                        newEpisodio.serieId = episodio.serieId;
                        newEpisodio.temporada = episodio.temporada;
                        newEpisodio.numero = episodio.numero;
                        bool isValid =
                            await validateImage(_imagemController.text);
                        newEpisodio.descricao =
                            _descricaoController.text.isNotEmpty
                                ? _descricaoController.text
                                : null;
                        newEpisodio.imagem =
                            isValid ? _imagemController.text : null;
                        //Se NÃO for valido e a descrição estiver vazia
                        if (!isValid && _descricaoController.text.isEmpty) {
                          SnackbarGlobal.show("Link Inválido!!");
                        } else {
                          episodio.descricao = newEpisodio.descricao??episodio.descricao;
                          episodio.imagem = newEpisodio.imagem??episodio.imagem;
                          _collection.editEpisodio(newEpisodio);
                        }
                      }
                      reload();
                    },
                    child: const Text("Salvar"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
