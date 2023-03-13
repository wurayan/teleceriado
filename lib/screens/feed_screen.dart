import 'package:bloco_notas/database/dao/series_dao.dart';
import 'package:flutter/material.dart';

import '../models/series.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final SeriesDao _dao = SeriesDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suas Séries'),
      ),
      body: FutureBuilder<List<Series>>(
          initialData: const [],
          future: _dao.findAllSeries(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                //TODO personalizar a tela de loading
                return const CircularProgressIndicator();
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Series> seriesList =
                    snapshot.data as List<Series>;
                print(seriesList.toString());
                return ListView.builder(
                  itemBuilder: (context, int index) {
                    final Series serie = seriesList[index];
                    return _SeriesItem(serie: serie,);
                  },
                  itemCount: seriesList.length,
                );
            }
            return const Text("Algo deu errado!");
          }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'addSerie');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _SeriesItem extends StatelessWidget {
  final Series serie;

  const _SeriesItem({
    required this.serie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: (){
          Navigator.pushNamed(context, 'addEpisodios', arguments: serie);
        },
        leading: Image.network(serie.imagem.toString()),
        title: Text(
          serie.nome,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}