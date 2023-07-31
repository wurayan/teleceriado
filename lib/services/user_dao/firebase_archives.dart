import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';

import 'firebase_export.dart';

class FirebaseArchives {
 final FirebaseStorage _storage = FirebaseStorage.instance;
 final FirebaseAuth _auth = FirebaseAuth.instance;
 final FirebaseUsers _users = FirebaseUsers();

 Future<String> uploadFile(File avatar) async {
  String url = "";
  // final filename = path.basename(avatar.path);
  final destination = "${_auth.currentUser!.uid}/avatar";
  try {
    final ref = _storage.ref().child("file/$destination");
    await ref.putFile(avatar);
    url = await ref.getDownloadURL();
    _users.updateAvatar(url);
  } catch (e) {
    throw Exception(e);
  }
  if(url.isEmpty) throw Exception("URL está vazia!");
  return url;
 } 
}