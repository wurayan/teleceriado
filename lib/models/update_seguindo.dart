import 'package:flutter/material.dart';

class UpdateSeguindo extends ChangeNotifier{
  bool? _update;
  bool? _headerChanged;

  bool? get update  => _update; 
  bool? get headerChanged => _headerChanged;

  set update (bool? value) {
    _update = value;
    notifyListeners();
    }
  
  set headerChanged(bool? value){
    _headerChanged = value;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    print(StackTrace.current);
    super.notifyListeners();
  }

  @override
  String toString() {
    return _update.toString();
  }
}