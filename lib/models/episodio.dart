class Episodio {
  int idEpisodio;
  int temporada;
  String nome;
  String estreia;
  String? imagem;
  String? descricao;

  Episodio({
    required this.idEpisodio,
    required this.temporada,
    required this.nome,
    required this.estreia,
    this.imagem,
    this.descricao,
  });

  Episodio.fromMap(Map<String, dynamic> map)
      : idEpisodio = map['episode'],
        temporada = map['season'],
        nome = map['name'],
        estreia = map['air_date'];
}
