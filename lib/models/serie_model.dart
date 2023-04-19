class Serie {
  int id;
  String nome;
  String permalink;
  String? estreia;
  String? encerramento;
  String pais;
  String emissora;
  String status;
  String thumbUrl;
  String? descricao;
  String? imagemUrl;
  List<dynamic>? episodios;

  Serie({
    required this.id,
    required this.nome,
    required this.permalink,
    required this.estreia,
    required this.encerramento,
    required this.pais,
    required this.emissora,
    required this.status,
    required this.thumbUrl,
    required this.descricao,
    required this.imagemUrl,
    required this.episodios
  });

  Serie.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nome = map['name'],
        permalink = map['permalink'],
        estreia = map['start_date'],
        encerramento = map['end_date'],
        pais = map['country'],
        emissora = map['network'],
        status = map['status'],
        thumbUrl = map['image_thumbnail_path'],
        descricao = map['description'],
        /
        imagemUrl = map['pictures']!=null ? map['pictures'] : map['image_path'],
        episodios = map['episodes']
        ;


  @override
  String toString() {
    return '$nome\nEstreia em: $estreia\nEmissora: $emissora\nSituação atual: $status';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'permalink': permalink,
      'estreia': estreia.toString(),
      'encerramento': encerramento!=null?encerramento.toString():'Em andamento',
      'pais': pais,
      'emissora': emissora,
      'status': status,
      'thumbUrl': thumbUrl,
    };
  }
}
