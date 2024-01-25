import 'package:restaurant_app/data/models/list_restaurant/data_item_list_restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;
  static const String _tableFavorite = "favorites";

  final String id = "id";
  final String name = "name";
  final String description = "description";
  final String city = "city";
  final String rating = "rating";
  final String pictureId = "pictureId";

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  Future<Database> _initialDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      "$path/restaurant.db",
      onCreate: (db, version) async {
        return await db.execute('''
        CREATE TABLE $_tableFavorite (
          $id TEXT PRIMARY KEY,
          $name TEXT,
          $description TEXT,
          $city TEXT,
          $rating REAL,
          $pictureId TEXT
        )
        ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initialDb();

    return _database;
  }

  Future<void> insertFavorite(DataItemListRestaurant dataRestaurant) async {
    final db = await database;
    await db!.insert(_tableFavorite, dataRestaurant.toJson());
  }

  Future<List<DataItemListRestaurant>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tableFavorite);
    return results.map((e) => DataItemListRestaurant.fromJson(e)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
