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

  Usuario({this.uid, this.username, this.firstTime, this.avatar, this.bio, this.seguidoresQtde, this.seguidores, this.editados});

  @override
  String toString() {
    return "UID: $uid\nUsername: $username";
  }
}
