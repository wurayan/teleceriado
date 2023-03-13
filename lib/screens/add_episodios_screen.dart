import 'package:bloco_notas/models/episodios.dart';
import 'package:bloco_notas/models/series.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddEpisodiosForm extends StatefulWidget {
  final Series serie;
  AddEpisodiosForm({super.key, required this.serie});

  @override
  State<AddEpisodiosForm> createState() => _AddEpisodiosFormState();
}

class _AddEpisodiosFormState extends State<AddEpisodiosForm> {
  final TextEditingController _idEpController = TextEditingController();

  final TextEditingController _nomeEpController = TextEditingController();

  final TextEditingController _imagemEpController = TextEditingController();

  final TextEditingController _descricaoEpController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Episódios"),
      ),
      //TODO ADICIOANR SINGLECHILDSCROLLVIEW ANTES DO PADDING
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Card(
                color: Color.fromARGB(255, 79, 84, 129),
                child: Row(
                  children: [
                    Image.network(widget.serie.imagem),
                    Text(widget.serie.nome)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextFormField(
                controller: _idEpController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: "Número do Episódio"),
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                controller: _nomeEpController,
                keyboardType: TextInputType.name,
                decoration:
                    const InputDecoration(labelText: "Nome do episódio"),
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                controller: _imagemEpController,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(labelText: "Link da Imagem"),
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                controller: _descricaoEpController,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: const InputDecoration(
                    labelText: "Descrição (max. 3 linhas)"),
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        int id = int.parse(_idEpController.text);
                        String nome = _nomeEpController.text;
                        if (_imagemEpController.text.isEmpty) {
                          _imagemEpController.text = 'https://unsplash.com/pt-br/fotografias/Vy2cHqm0mCs';
                        }
                        String imagem = _imagemEpController.text;
                        String descricao = _descricaoEpController.text;
                        final Episodios newEpisodio = Episodios(
                            id, nome, imagem, descricao, widget.serie.id);

                        Navigator.pop(context, true);
                      },
                      child: const Text("Create"))),
            ),
          ],
        ),
      ),
    );
  }
}
