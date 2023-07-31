import 'package:flutter/material.dart';

class Usuario extends ChangeNotifier {
  String? uid;
  String? username;
  bool? firstTime;
  String? avatar;
  String? bio;
  int? seguidoresQtde;
  List<String>? seguidores;
  int? editados;
  int? serieFavorita;
  int? assistindoAgora;
  String? header;

  // String? get uid => _uid;
  // String? get username => _username;
  // bool? get firstTime => _firstTime;
  // String? get avatar => _avatar;
  // String? get bio => _bio;
  // int? get seguidoresQtde => _seguidoresQtde;
  // List<String>? get seguidores => _seguidores;
  // int? get editados => _editados;
  // int? get serieFavorita => _serieFavorita;
  // int? get assistindoAgora => _assistindoAgora;
  // String? get header => _header;

  // set uid(String? value) => _uid = value;
  // set username(String? value) => _username = value;
  // set firstTime(bool? value) => _firstTime = value;
  // set avatar(String? value) => _avatar = value;
  // set bio(String? value) => _bio = value;
  // set seguidoresQtde(int? value) => _seguidoresQtde = value;
  // set seguidores(List<String>? value) => _seguidores = value;
  // set editados(int? value) => _editados = value;
  // set serieFavorita(int? value) => _serieFavorita = value;
  // set assistindoAgora(int? value) => _assistindoAgora = value;
  // set header(String? value) => _header = value;
  Usuario(
      {this.uid,
      this.username,
      this.firstTime,
      this.avatar,
      this.bio,
      this.seguidoresQtde,
      this.seguidores,
      this.editados,
      this.serieFavorita,
      this.assistindoAgora,
      this.header});

  @override
  String toString() {
    return "UID: $uid\nUsername: $username";
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is Usuario && other.uid == uid && other.username == username;
  }

  @override
  int get hashCode => Object.hash(uid, username);

  update(Usuario other) {
    uid = other.uid;
    username = other.username;
    firstTime = other.firstTime;
    avatar = other.avatar;
    bio = other.bio;
    seguidoresQtde = other.seguidoresQtde;
    seguidores = other.seguidores;
    editados = other.editados;
    serieFavorita = other.serieFavorita;
    assistindoAgora = other.assistindoAgora;
    header = other.header;
    notifyListeners();
  }
}
