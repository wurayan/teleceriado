import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:teleceriado/models/error_handler.dart';
import 'package:teleceriado/services/prefs.dart';

import '../../models/version.dart';

class FirebaseMisc {
  final Prefs prefs = Prefs();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  checkVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var res = await db.collection("/admin").doc("/versoes").get();
    Map map = res.data() ?? {};
    int localNum = int.parse(packageInfo.buildNumber);
    if(localNum>=map["versaoNum"]) return;
    Version version = Version();
    version.localVersion = packageInfo.version;
    version.newVersion = map["versaoNome"];
    version.versionLink = map["versaoLink"];
    ErrorHandler.versionOutdated(version);
  }
}