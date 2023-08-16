// ignore_for_file: unnecessary_getters_setters


class Episodio {
  int? _id;
  int? _serieId;
  int? _numero;
  int? _temporada;
  String? _nome;
  String? _serie;
  String? _descricao;
  String? _imagem;
  String? _criador;
  String? _criadorId;
  bool? _wasEdited;

  int? get id => _id;
  int? get serieId => _serieId;
  int? get numero => _numero;
  int? get temporada => _temporada;
  String? get nome => _nome;
  String? get serie => _serie;
  String? get descricao => _descricao;
  String? get imagem => _imagem;
  String? get criador => _criador;
  String? get criadorId => _criadorId;
  bool? get wasEdited => _wasEdited;

  set id(int? value) => _id = value;
  set serieId(int? value) => _serieId = value;
  set numero(int? value) => _numero = value;
  set temporada(int? value) => _temporada = value;
  set nome(String? value) => _nome = value;
  set serie (String? value)  => _serie = value;
  set descricao(String? value) => _descricao = value;
  set imagem(String? value) => _imagem = value;
  set criador(String? value) => _criador = value;
  set criadorId(String? value) => _criadorId = value;
  set wasEdited(bool? value) => _wasEdited = value;

  @override
  String toString(){
    return "$id\n$serieId$numero\n$nome\n$serie"; 
  }

  copyWith({
  int? newId,
  int? newSerieId,
  int? newNumero,
  int? newTemporada,
  String? newNome,
  String? newSerie,
  String? newDescricao,
  String? newImagem,
  String? newCriador,
  bool? newWasEdited,
  }){
    Episodio res = Episodio();
    res.id =  newId ?? id;
    res.serieId =newSerieId ?? serieId;  
    res.numero =newNumero ?? numero;  
    res.temporada =newTemporada ?? temporada;  
    res.nome =  newNome ?? nome;
    res.serie =  newSerie ?? serie;
    res.descricao =  newDescricao ?? descricao;
    res.imagem =  newImagem ?? imagem;
    res.wasEdited = newWasEdited ?? wasEdited;
    res.criador = newCriador ?? criador;
    return res;
  }


}
