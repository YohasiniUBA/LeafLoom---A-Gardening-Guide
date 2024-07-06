// database_helper.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';


class DatabaseHelper {
  static Database? _database;

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  static const String tableName = 'plants_list';
  static const String columnUser = 'user';
  static const String columnName = 'name';
  static const String columnSpecies = 'species';
  static const String columnPlantedDate = 'planted_date';
  static const String columnLocation = 'location';
  static const String columnSoilType = 'soil_type';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }


  Future<Database> initDatabase() async {
    print('hey');
    return openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) async {
        try{
        print('before user created');
        await db.execute(
          'CREATE TABLE user(username TEXT PRIMARY KEY, password TEXT)',
        );
        print('user created');
        // Create the 'plants_list' table
        await db.execute('''
        CREATE TABLE $tableName (
          $columnUser TEXT,
          $columnName TEXT,
          $columnSpecies TEXT,
          $columnPlantedDate TEXT,
          $columnLocation TEXT,
          $columnSoilType TEXT
        )
      ''');
        print('plants created');}
        catch (e) {
          print('Error creating tables: $e'); // Log the error for debugging
        }
      },
      version: 1,
    );

  }



  Future<bool> verifyUser(String username, String password) async {
    final db = await database;
    var result = await db.query(
      'user',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return result.isNotEmpty;
  }

  Future<bool> isUsernameTaken(String username) async {
    final db = await database;
    var result = await db.query(
      'user',
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isNotEmpty;
  }

  Future<void> registerUser(String username, String password) async {
    final db = await database;
    await db.insert(
      'user',
      {'username': username, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<void> insertPlant(Map<String, dynamic> plant) async {
    print('data received');
    final db = await database;
    await db.insert('plants_list', plant);
    print('plant inserted');
  }


  Future<List<Map<String, dynamic>>> queryAllPlants(String username) async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> table = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='plants_list'",
      );
      if (table.isEmpty) {
        await initDatabase();
      }

      final userExists = await isUsernameTaken(username);
      if (!userExists) {
        print('Username $username does not exist.');
        // Return an empty list with a single empty map representing an empty row
        return [{}];
      }

      final plants = await db.rawQuery(
        '''
      SELECT 
        name,
        species,
        planted_date,
        location,
        soil_type
      FROM 
        plants_list 
      WHERE 
        user = ?
      ''',
        [username],
      );

      print('Plants for $username: $plants');
      return plants;
    } catch (e) {
      print('Error querying plants: $e');
      return [];
    }
  }


}



