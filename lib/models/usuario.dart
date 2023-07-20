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

  Usuario({this.uid, this.username, this.firstTime, this.avatar, this.bio, this.seguidoresQtde, this.seguidores, this.editados, this.serieFavorita, this.assistindoAgora, this.header});

  @override
  String toString() {
    return "UID: $uid\nUsername: $username";
  }

  @override
  bool operator == (Object other){
    if(other.runtimeType != runtimeType) return false;
    return other is Usuario && other.uid == uid && other.username == username;
  }

  @override
  int get hashCode => Object.hash(uid, username);
}
