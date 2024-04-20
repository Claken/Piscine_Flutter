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
    await db.insert(_tableName, entry.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<MyEntry>> getEntries() async {
    // Get a reference to the database.
    final db = await _database();

    // Query the table for all the dogs.
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    // Convert the list of each dog's fields into a list of `Dog` objects.
    return List.generate(maps.length, (i) {
      return MyEntry(
          id: maps[i]['id'] as int,
          usermail: maps[i]['usermail'] as String,
          date: DateTime.parse(maps[i]['date']),
          title: maps[i]['title'] as String,
          feeling: maps[i]['feeling'] as String,
          content: maps[i]['content'] as String);
    });
  }

  static update({required MyEntry entry}) async {
    final db = await _database();

    await db.update(
      _tableName,
      entry.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [entry.id],
    );
  }

  static delete({required MyEntry entry}) async {
    final db = await _database();

    await db.delete(
      _tableName,
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [entry.id],
    );
  }
}
