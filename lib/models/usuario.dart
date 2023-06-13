import 'package:flutter/material.dart';

class Usuario extends ChangeNotifier {
  String? uid;
  String? username;
  bool? firstTime;
  String? avatar;

  Usuario({this.uid, this.username, this.firstTime, this.avatar});
}
