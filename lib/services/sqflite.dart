

// Future<Database> getDatabase() async {
//   final String dbPath = await getDatabasesPath();
//   final String path = '$dbPath/favoritos.db';
//   return openDatabase(path, onCreate: (db, version) {
//     db.execute(
//       "CREATE TABLE favoritos (dataErro VARCHAR, tipo VARCHAR(50), mensagem VARCHAR(255))"
//     );
//   }, version: 2 );
// }