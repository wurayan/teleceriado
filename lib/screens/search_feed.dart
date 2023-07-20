import 'package:flutter/material.dart';
import 'package:teleceriado/screens/serie/serie_page.dart';
import 'package:teleceriado/services/api_service.dart';

import '../models/serie.dart';

class SearchFeed extends StatefulWidget {
  const SearchFeed({super.key});

  @override
  State<SearchFeed> createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {
  final ApiService _api = ApiService();

  final TextEditingController _searchController = TextEditingController();

  final UnderlineInputBorder _underline =
      const UnderlineInputBorder(borderSide: BorderSide.none);

  List<Serie>? serie;
  reloadPage(String value) async {
    serie = await _api.searchSerie(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Pesquisar...',
            enabledBorder: _underline,
            focusedBorder: _underline,
          ),
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus!.unfocus(),
              onChanged: (value) => reloadPage(value),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          serie == null || serie!.isEmpty
          ? SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: height*0.4),
              child: const Center(
                child: Text('Não encontramos nada...'),
              ),
            ),
          )
          : _ResultGrid(
              resultado: serie!,
            ),
        ],
      ) 
      
      
    );
  }
}

class _ResultGrid extends StatelessWidget {
  final List<Serie> resultado;
  _ResultGrid({required this.resultado});
  final ApiService _api = ApiService();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          Serie serie = resultado[index];
          return Container(
            decoration: BoxDecoration(
                border:
                    Border.all(width: 0.5, color: Colors.blueGrey.shade700)),
            child: InkWell(
              onTap: () {
                _api.getSerie(serie.id!, 1).then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeriePage(serie: value),
                    ),
                  );
                });
              },
              child: serie.poster != null ?  
              Image.network(
                _api.getSeriePoster(serie.poster!),
                fit: BoxFit.cover,
                width: width * 0.65,
                height: width,
              )
              : Container(
                alignment: Alignment.center,
                child: const Text("Imagem não Encontrada", textAlign: TextAlign.center,),
              ),
            ),
          );
        }, childCount: resultado.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            childAspectRatio: 0.7));
  }
}
