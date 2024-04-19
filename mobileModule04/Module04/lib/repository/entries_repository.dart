import 'package:diaryapp/models/entry.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class EntriesRepository {
  static const _dbName = 'entries_repository.db';
  static const _tableName = 'notes';

  // static so we call call the function without the need to instantiate the class
  static Future<Database> _database() async { 
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), _dbName),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, usermail TEXT, date TEXT, title TEXT, feeling TEXT, content TEXT)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    return database;
  }

  static insert({required MyEntry entry}) async {
    final db = await _database();
    await db.insert(
      _tableName,
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }
}
