import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:teleceriado/models/episodio.dart';

class EditEpisodio extends StatefulWidget {
  final Episodio episodio;
  final String imagemUrl;
  const EditEpisodio(
      {super.key, required this.episodio, required this.imagemUrl});

  @override
  State<EditEpisodio> createState() => _EditEpisodioState();
}

class _EditEpisodioState extends State<EditEpisodio> {
  bool isEditing = true;
  final TextEditingController _descricaoController = TextEditingController();

  final InputDecoration _descricaoDecoration = const InputDecoration(
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0)),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 0)));

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      clipBehavior: Clip.hardEdge,
      child: Container(
        color: Colors.blueGrey[900],
        width: width * 0.9,
        height: height * 0.6,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: width * 0.9,
                  height: height * 0.2,
                  child: Image.network(
                    widget.imagemUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.03),
                  child: SizedBox(
                    width: width * 0.8,
                    height: height * 0.2,
                    child: isEditing
                        ? TextFormField(
                            controller: _descricaoController,
                            keyboardType: TextInputType.text,
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).unfocus();
                            },
                            maxLength: 144,
                            expands: true,
                            minLines: null,
                            maxLines: null,
                            decoration: _descricaoDecoration)
                        : Text(
                            widget.episodio.descricao ??
                                'Adicionar Descrição...',
                            style: const TextStyle(fontSize: 16)),
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Cancelar'),
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.17, left: width * 0.03),
              child: Text(
                '${widget.episodio.idEpisodio}. ${widget.episodio.nome}',
                style: const TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
