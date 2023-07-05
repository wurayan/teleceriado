import 'package:flutter/foundation.dart';

class Version extends ChangeNotifier {
  String? _version;

  String? get version => _version;

  set version(String? value) => _version = value;

}
