import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  MyDatabase() {
    openDB();
  }

  late Database database;
  openDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cart.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('CREATE TABLE Test (id INTEGER, name TEXT)');
    });
  }

  writeRec(id, name) async {
    int id1 = await database
        .rawInsert('INSERT INTO Test(id, name) VALUES($id, "$name")');
    print('inserted1: $id1');}
}