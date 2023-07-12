import 'package:flutter/material.dart';

class UpdateSeguindo extends ChangeNotifier{
  bool? _update;

  bool? get update  => _update; 

  set update (bool? value) {
    _update = value;
    notifyListeners();
    }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  @override
  String toString() {
    
    return _update.toString();
  }
}