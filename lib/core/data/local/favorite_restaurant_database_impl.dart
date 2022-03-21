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
  final String _isFavorite = "favorite";

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
               $_favoriteRating REAL,
               $_isFavorite INTEGER
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
    dbObject[_isFavorite] = 1;
    try {
      await db.insert(_tableName, dbObject);
    } catch (e) {
      await db.update(
        _tableName,
        dbObject,
        where: "$_favoriteId = ?",
        whereArgs: [dbObject[_favoriteId]],
      );
    }
  }

  @override
  Future<List<SimpleRestaurant>> getFavoriteRestaurantList() async {
    final db = await _getDatabase;
    final dbObject = await db.query(
      _tableName,
      where: "$_isFavorite = ?",
      whereArgs: [1],
    );
    return dbObject.map((map) => SimpleRestaurant.fromJson(map)).toList();
  }

  @override
  Future<bool> isRestaurantFavorite(String id) async {
    final db = await _getDatabase;
    final dbObject = await db.query(
      _tableName,
      where: "$_favoriteId = ? AND $_isFavorite = ?",
      whereArgs: [id, 1],
      limit: 1,
    );
    return dbObject.isNotEmpty;
  }

  @override
  Future<void> removeRestaurantFromFavorite(String id) async {
    final db = await _getDatabase;
    final dbObject = await db.query(
      _tableName,
      where: "$_favoriteId = ? AND $_isFavorite = ?",
      whereArgs: [id, 1],
      limit: 1,
    );

    final updatedDbObject = Map.of(dbObject.first);
    updatedDbObject.update(_isFavorite, (favorite) => 0, ifAbsent: () => 0);

    await db.update(
      _tableName,
      updatedDbObject,
      where: "$_favoriteId = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<void> addRestaurantToDatabase(Map<String, dynamic> dbObject) async {
    final db = await _getDatabase;
    final String objId = dbObject[_favoriteId];
    final isFavorite = await isRestaurantFavorite(objId);

    // Obj is a fav restaurant, we are 100% sure it's in the database
    if (isFavorite) {
      dbObject[_isFavorite] = 1;
      await db.update(
        _tableName,
        dbObject,
        where: "$_favoriteId = ?",
        whereArgs: [objId],
      );
    } else {
      // Obj is not a fav restaurant, obj might or might not be in the database
      dbObject[_isFavorite] = 0;
      try {
        // Assume that obj is not in the db
        await db.insert(_tableName, dbObject);
      } catch (e) {
        // Insertion failed, obj is in the db, update values instead
        await db.update(
          _tableName,
          dbObject,
          where: "$_favoriteId = ?",
          whereArgs: [objId],
        );
      }
    }
  }

  @override
  Future<List<SimpleRestaurant>> getAllRestaurants() async {
    final db = await _getDatabase;
    final dbObjects = await db.query(_tableName);

    return dbObjects.map((obj) => SimpleRestaurant.fromJson(obj)).toList();
  }
}
