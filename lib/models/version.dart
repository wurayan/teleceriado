// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/foundation.dart';

class Version extends ChangeNotifier {
  String? _localVersion;
  String? _newVersion;
  String? _versionLink;

  String? get localVersion => _localVersion;
  String? get newVersion => _newVersion;
  String? get versionLink => _versionLink;

  set localVersion(String? value) => _localVersion = value;
  set newVersion(String? value) => _newVersion = value;
  set versionLink(String? value) => _versionLink = value;

}
