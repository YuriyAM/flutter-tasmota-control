import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasmota_control/models/LightBulb.dart';
import 'package:tasmota_control/services/TasmotaProvider.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database _database;

  String lightbulbTable = 'lightbulbs';
  String columnId = 'id';
  String columnIp = 'ip';
  String columnLabel = 'label';
  String columnAvailable = 'available';
  String columnPower = 'power';
  String columnColor = 'color';

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    String path = await getDatabasesPath();
    path = join(path, 'tasmota.db');
    print("Entered path $path");

    // Open/create the database at a given path
    var lightBulbDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return lightBulbDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $lightbulbTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnIp TEXT, '
        '$columnLabel TEXT, $columnAvailable INTEGER, $columnPower INTEGER, $columnColor TEXT)');
  }

  // Fetch Operation: Get all light bulb objects from database
  Future<List<Map<String, dynamic>>> getLightbulbMapList() async {
    Database db = await this.database;
    return await db.query(lightbulbTable);
  }

  Future<Map<String, dynamic>> getLightbulbMap(LightBulb lightBulb) async {
    Database db = await this.database;
    var list = await db.query(lightbulbTable,
        where: '$columnIp = ?', whereArgs: [lightBulb.ip]);
    return list[0];
  }

  // Insert Operation: Insert a LightBulb object to database
  Future<int> insertLB(LightBulb lightBulb) async {
    Database db = await this.database;
    return await db.insert(lightbulbTable, lightBulb.toMap());
  }

  // Update Operation: Update a LightBulb object and save it to database
  Future<int> updateLB(LightBulb lightBulb) async {
    var db = await this.database;
    return await db.update(lightbulbTable, lightBulb.toMap(),
        where: '$columnIp = ?', whereArgs: [lightBulb.ip]);
  }

  // Delete Operation: Delete a LightBulb object from database
  Future<int> deleteLB(LightBulb lightBulb) async {
    var db = await this.database;
    return await db.delete(lightbulbTable,
        where: '$columnIp = ?', whereArgs: [lightBulb.ip]);
  }

  // Get number of LightBulb objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $lightbulbTable');
    return Sqflite.firstIntValue(x);
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'LB List' [ List<LightBulb> ]
  Future<List<LightBulb>> getLightbulbList() async {
    var lightbulbMapList =
        await getLightbulbMapList(); // Get 'Map List' from database
    int count =
        lightbulbMapList.length; // Count the number of map entries in db table

    List<LightBulb> lightBulbList = List<LightBulb>();
    // For loop to create a 'LightBulb List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      lightBulbList.add(LightBulb.fromMap(lightbulbMapList[i]));
    }
    return lightBulbList;
  }

  Future<LightBulb> getLightbulb(LightBulb lightBulb) async {
    var lightbulbMap = await getLightbulbMap(lightBulb);
    return LightBulb.fromMap(lightbulbMap);
  }

  Future<bool> checkUnique(String ip) async {
    Database db = await this.database;
    var query =
        await db.rawQuery('SELECT * FROM $lightbulbTable WHERE $columnIp=$ip');
    return query.isEmpty;
  }

  Future<void> updateDatabaseFromApi() async {
    TasmotaProvider apiProvider = TasmotaProvider();
    var lightBulbList = await getLightbulbList();
    for (var item in lightBulbList) {
      item.available = await apiProvider.checkAvailable(item.ip);
      if (item.available) {
        var apiLB = await apiProvider.fetchSettings(item);
        item = LightBulb.fromJson(item, jsonDecode(apiLB.body));
      }
      updateLB(item);
    }
  }

  Future<void> updateLightBulbFromApi(LightBulb lightBulb) async {
    TasmotaProvider apiProvider = TasmotaProvider();
    lightBulb.available = await apiProvider.checkAvailable(lightBulb.ip);
    if (lightBulb.available) {
      var apiLB = await apiProvider.fetchSettings(lightBulb);
      lightBulb = LightBulb.fromJson(lightBulb, jsonDecode(apiLB.body));
    }
    updateLB(lightBulb);
  }
}
