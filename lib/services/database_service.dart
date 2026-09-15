import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? database;

  Future<Database> getDatabase() async {
    if (database != null) {
      return database!;
    }

    String path = join(await getDatabasesPath(), 'machine_test_tinos_software.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE session(id INTEGER PRIMARY KEY, loggedIn INTEGER)',
        );
      },
    );

    return database!;
  }

  Future<void> saveLogin() async {
    final db = await getDatabase();

    await db.delete('session');

    await db.insert('session', {
      'id': 1,
      'loggedIn': 1,
    });
  }

  Future<bool> isLoggedIn() async {
    final db = await getDatabase();

    final result = await db.query('session');

    if (result.isEmpty) {
      return false;
    }

    return result.first['loggedIn'] == 1;
  }

  Future<void> logout() async {
    final db = await getDatabase();
    await db.delete('session');
  }
}