import 'package:flutter/material.dart';
import 'package:teleceriado/utils/decoration.dart';
import '../../../models/episodio.dart';
import '../../../services/api_service.dart';
import '../../../services/user_dao/firebase_export.dart';

class EditEpisodio extends StatefulWidget {
  final Episodio episodio;
  final VoidCallback reload;
  const EditEpisodio({super.key, required this.episodio, required this.reload});

  @override
  State<EditEpisodio> createState() => _EditEpisodioState();
}

class _EditEpisodioState extends State<EditEpisodio> {
  final FirebaseEpisodios _episodios = FirebaseEpisodios();

  final ApiService _api = ApiService();

  final TextEditingController _descricaoController = TextEditingController();

  final TextEditingController _nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: height * 0.2,
          decoration: BoxDecoration(
              image: widget.episodio.imagem != null
                  ? DecorationImage(
                      image: Image.network(
                        widget.episodio.wasEdited == true
                            ? widget.episodio.imagem!
                            : _api.getSeriePoster(widget.episodio.imagem!),
                      ).image,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    )
                  : null),
          child: Container(
            width: double.infinity,
            height: height * 0.2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Theme.of(context).dialogBackgroundColor
                ],
              ),
            ),
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Nome do Episódio:",
                      style: TextStyle(fontSize: 14)),
                  TextFormField(
                    controller: _nomeController,
                    keyboardType: TextInputType.text,
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus!.unfocus(),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.fromLTRB(width * 0.05, height * 0.01, width * 0.05, 0),
          child: const Text(
            "Sua descrição:",
            style: TextStyle(fontSize: 14),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: SizedBox(
            height: height * 0.17,
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
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.fromLTRB(width * 0.05, height * 0.05, width * 0.05, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: width * 0.3,
                height: height * 0.05,
                child: ElevatedButton(
                  onPressed: () {
                    widget.reload();
                  },
                  child: const Text("Cancelar"),
                ),
              ),
              SizedBox(
                width: width * 0.3,
                height: height * 0.05,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_descricaoController.text.isNotEmpty ||
                        _nomeController.text.isNotEmpty) {
                      _salvar();
                    }
                    widget.reload();
                  },
                  child: const Text("Salvar"),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _salvar() async {
    // bool isValid = await validateImage(_imagemController.text);
    String? nome =
        _nomeController.text.isNotEmpty ? _nomeController.text : null;
    String? descricao =
        _descricaoController.text.isNotEmpty ? _descricaoController.text : null;
    // String? imagem = isValid ? _imagemController.text : null;
    // if (!isValid && descricao == null && nome == null) {
    // SnackbarGlobal.show("Link Inválido!!");
    // } else {
    widget.episodio.descricao = descricao ?? widget.episodio.descricao;
    widget.episodio.nome = nome ?? widget.episodio.nome;
    // episodio.imagem = imagem ?? episodio.imagem;
    //Nós estamos fazendo isso pq precisamos que o episodio original ocntinue funcionando mesmo com imagem nula e tambem precisamos passar uma instancia de episodio com null caso imagem invalida
    Episodio newEp = widget.episodio;
    // newEp.imagem = imagem;
    _episodios.editEpisodio(newEp);
    // }
  }
}
