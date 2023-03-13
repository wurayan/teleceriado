import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = "$dbPath/series.db";
  return openDatabase(path, onCreate: (db, version) {
    db.execute('CREATE TABLE series (id TEXT PRIMARY KEY, nome VARCHAR(100), descricao TEXT, imagem TEXT)');
    db.execute('CREATE TABLE episodios (id TEXT PRIMARY KEY, serieId TEXT, nome VARCHAR(100), descricao TEXT, imagem TEXT)');
  }, version: 1);
}