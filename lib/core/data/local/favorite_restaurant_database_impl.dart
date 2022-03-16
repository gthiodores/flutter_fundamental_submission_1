import 'package:path/path.dart';
import 'package:restaurant_app/core/data/local/favorite_restaurant_database.dart';
import 'package:restaurant_app/core/model/simple_restaurant.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteRestaurantDatabaseImpl extends IFavoriteRestaurantDatabase {
  // Database configuration
  final String _databaseName = "favorite_restaurant";
  final String _tableName = "favorite_table";
  final int _databaseVersion = 1;

  // Favorite table columns
  final String _favoriteId = "id";
  final String _favoriteName = "name";
  final String _favoriteDescription = "description";
  final String _favoritePictureId = "pictureId";
  final String _favoriteCity = "city";
  final String _favoriteRating = "rating";

  // Singleton database instance
  static Database? _database;

  Future<Database> get _getDatabase async {
    _database ??= await _initializeDb();

    return _database!;
  }

  Future<Database> _initializeDb() async {
    final path = await getDatabasesPath();
    final db = openDatabase(
      join(path, '$_databaseName.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               $_favoriteId TEXT PRIMARY KEY,
               $_favoriteName TEXT, 
               $_favoriteDescription TEXT,
               $_favoritePictureId TEXT,
               $_favoriteCity TEXT,
               $_favoriteRating REAL
             )''',
        );
      },
      version: _databaseVersion,
    );

    return db;
  }

  @override
  Future<void> addRestaurantToFavorite(Map<String, dynamic> dbObject) async {
    final db = await _getDatabase;
    await db.insert(_tableName, dbObject);
  }

  @override
  Future<List<SimpleRestaurant>> getFavoriteRestaurantList() async {
    final db = await _getDatabase;
    final dbObject = await db.query(_tableName);
    return dbObject.map((map) => SimpleRestaurant.fromJson(map)).toList();
  }

  @override
  Future<bool> isRestaurantFavorite(String id) async {
    final db = await _getDatabase;
    final dbObject = await db.query(
      _tableName,
      where: "$_favoriteId = ?",
      whereArgs: [id],
      limit: 1,
    );
    return dbObject.isNotEmpty;
  }

  @override
  Future<void> removeRestaurantFromFavorite(String id) async {
    final db = await _getDatabase;
    await db.delete(
      _tableName,
      where: "$_favoriteId = ?",
      whereArgs: [id],
    );
  }
}
