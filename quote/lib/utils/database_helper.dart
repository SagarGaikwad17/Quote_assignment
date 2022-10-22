import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/favourite_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  late Database db;

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  // ...
  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'quotes_demo.db'),
      onCreate: (database, version) async {
        await database.execute(
          """
            CREATE TABLE quotes (
              id Text PRIMARY KEY , 
              quote TEXT NOT NULL
            )
          """,
        );
      },
      version: 1,
    );
  }
// ...

  // ...
  Future<int> insertQuote(FavouriteQuote user) async {
    int result = await db.insert('quotes', user.toMap());
    return result;
  }

  Future<int> updateQuote(FavouriteQuote user) async {
    int result = await db.update(
      'quotes',
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
    return result;
  }

  Future<List<FavouriteQuote>> retrieveQuotes() async {
    final List<Map<String, Object?>> queryResult = await db.query('quotes');
    return queryResult.map((e) => FavouriteQuote.fromMap(e)).toList();
  }

  Future<List<FavouriteQuote>> searchQuote(String word) async {
    final List<Map<String, Object?>> queryResult =
        // await db.query('quotes', where: "quote LIKE '%?%'", whereArgs: [word]);
        await db
            .rawQuery("SELECT * FROM quotes WHERE quote LIKE ?", ['%$word%']);
    return queryResult.map((e) => FavouriteQuote.fromMap(e)).toList();
  }

  Future<void> deleteQuote(String id) async {
    await db.delete(
      'quotes',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    return await db.rawDelete("Delete from quotes");
  }
// ...

}
