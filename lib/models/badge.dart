class UserBadge {
  String? nome;
  String? link;
  String? descricao;

  UserBadge({this.nome, this.link, this.descricao});

  @override
  String toString(){
    return "$nome\n$link";
  }
  
}