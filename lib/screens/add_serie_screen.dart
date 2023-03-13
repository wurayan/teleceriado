import 'package:bloco_notas/database/dao/series_dao.dart';
import 'package:bloco_notas/models/series.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class SeriesForm extends StatefulWidget {
  const SeriesForm({super.key});

  @override
  State<SeriesForm> createState() => _SeriesFormState();
}

class _SeriesFormState extends State<SeriesForm> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _imagemController = TextEditingController();
 

  final SeriesDao _dao = SeriesDao();

  // @override
  // void initState() {
  //   super.initState();
  //   _imagemController.text = 'https://unsplash.com/pt-br/fotografias/Vy2cHqm0mCs';
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Série"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: "Nome da Série"),
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: _descricaoController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(labelText: "Descrição"),
                style: const TextStyle(fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                controller: _imagemController,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(labelText: "Link da Imagem"),
                style: const TextStyle(fontSize: 24),
                
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                           if (_imagemController.text.isEmpty) {
                          _imagemController.text = 'https://unsplash.com/pt-br/fotografias/Vy2cHqm0mCs';
                        }
                        });
                        String nome = _nomeController.text;
                        String descricao = _descricaoController.text;
                        String id = const Uuid().v1();
                        String imagem = _imagemController.text;
                        final Series newSerie =
                            Series(id, nome, descricao, imagem);
                        _dao.save(newSerie);
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
