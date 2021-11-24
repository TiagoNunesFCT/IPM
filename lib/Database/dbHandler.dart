import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


/**
 *
 *      READ ME
 *      READ ME
 *      READ ME
 *
 *      Tables necessárias:
 *      Users
 *      Settings
 *      Zones (cidade, país, e coordenadas no mapa)
 *      Overall Classifications (main key é o id da zona)
 *      Infos (todas as infos vão estar na mesma table, e vão ter uma tag que é o tipo de info. Quando selecionamos o tipo de info é que filtramos pelo tipo de tag (serviços, etc))
 *      Individual Ratings, (main key é o id da zona), tem como attrs o nome da pessoa, link para a imagem (ver como fazer), número de estrelas, timestamp e descrição do feedback
 *      Forums (main key é o id da zona), tem como attrs o nome da pessoa, link para a imagem (ver como fazer), título , descrição do post e respostas? (ver como fazer)
 *      Crime News (main key é o id da zona), tem como attrs o nome do canal de notícias, link para o logotipo (ver como fazer), breve descrição da notícia, hyperlink para o artigo (maybe fake), e timestamp
 */

//This Class is what interfaces directly with the SQLite Database (hence it's called Database Helper)
class DatabaseHelper {
  //Database Name File
  static final _databaseName = "waypoint_db.db";

  //Database Version. Change This when the database has been modified (eg. columns added, etc.), these changes must be implemented in the onUpgrade Function
  static final _databaseVersion = 9;

  //Waypoint Table
  static final table = 'wayp_table';

  //Settings Table (in case multiple configurations are added in the future)
  // ignore: non_constant_identifier_names
  static final set_table = 'settings_table';

  //Tags Table
  // ignore: non_constant_identifier_names
  static final tag_table = 'tags_table';

  //Themes Table
  // ignore: non_constant_identifier_names
  static final them_table = 'themes_table';

  //Names of Columns, grouped by table
  //Waypoint Columns
  static final columnId = 'wayp_id';
  static final columnLatitude = 'wayp_lat';
  static final columnLongitude = 'wayp_lon';
  static final columnAltitude = 'wayp_alt';
  static final columnAccuracy = 'wayp_acc';
  static final columnSpeed = 'wayp_spd';
  static final columnHeading = 'wayp_hdg';
  static final columnTimestamp = 'wayp_tim';
  static final columnName = 'wayp_nam';
  static final columnSource = 'wayp_src';
  static final columnTags = 'wayp_tag';

  //Settings Columns
  static final columnSettingsId = 'settings_id';
  static final columnLanguage = 'settings_lang';
  static final columnCoordinates = 'settings_coord';
  static final columnUnits = 'settings_unit';
  static final columnStreamFrequency = 'settings_freq';
  static final columnPowerSave = 'settings_power';
  static final columnStoragePath = 'settings_stor';
  static final columnReceiver = 'settings_recv';
  static final columnSound = 'settings_snd';
  static final columnNotifications = 'settings_note';
  static final columnScreenTimeout = 'settings_tim';
  static final columnCurrentTheme = 'settings_cur';
  static final columnDirty = 'settings_dirty';
  static final columnAutoZoom = 'settings_zoom';

  //Tags Columns
  static final columnTagId = 'tag_id';
  static final columnTagName = 'tag_name';
  static final columnTagTheme = 'tag_theme';
  static final columnTagOrder = 'tag_order';

  //Themes Columns
  static final columnThemId = 'them_id';
  static final columnThemName = 'them_name';
  static final columnThemSector = 'them_sect';

  /*

    DATABASE SEEDS - - - THESE WILL BE THE DEFAULT THEMES/TAGS. THEY WILL APPEAR WHENEVER THE DATABASE IS CREATED

   */


  /*
  Theme geoNames = new Theme(themNam: "GeoNames", themSect: 0);
  Theme outdoorActivities = new Theme(themNam: "Outdoor Activities", themSect: 0);
  Theme travelling = new Theme(themNam: "Travelling", themSect: 0);

  Tag waterHarbour = new Tag(tagNam: "Water/Harbour", tagThm: "GeoNames", tagOrd: 1);
  Tag parksArea = new Tag(tagNam: "Parks/Area", tagThm: "GeoNames", tagOrd: 2);
  Tag cityVillage = new Tag(tagNam: "City/Village", tagThm: "GeoNames", tagOrd: 3);
  Tag roadRailroad = new Tag(tagNam: "Road/Railroad", tagThm: "GeoNames", tagOrd: 4);
  Tag spotBuilding = new Tag(tagNam: "Spot/Building", tagThm: "GeoNames", tagOrd: 5);
  Tag mountainRock = new Tag(tagNam: "Mountain/Rock", tagThm: "GeoNames", tagOrd: 6);
  Tag undersea = new Tag(tagNam: "Undersea", tagThm: "GeoNames", tagOrd: 7);
  Tag forest = new Tag(tagNam: "Forest", tagThm: "GeoNames", tagOrd: 8);

  Tag hiking = new Tag(tagNam: "Hiking", tagThm: "Outdoor Activities", tagOrd: 1);
  Tag running = new Tag(tagNam: "Running", tagThm: "Outdoor Activities", tagOrd: 2);
  Tag cyclingBiking = new Tag(tagNam: "Cycling/Biking", tagThm: "Outdoor Activities", tagOrd: 3);
  Tag offroad = new Tag(tagNam: "Offroad", tagThm: "Outdoor Activities", tagOrd: 4);
  Tag sailing = new Tag(tagNam: "Sailing", tagThm: "Outdoor Activities", tagOrd: 5);
  Tag flying = new Tag(tagNam: "Flying", tagThm: "Outdoor Activities", tagOrd: 6);

  Tag monumentMuseum = new Tag(tagNam: "Monument/Museum", tagThm: "Travelling", tagOrd: 1);
  Tag natureParks = new Tag(tagNam: "Nature/Parks", tagThm: "Travelling", tagOrd: 2);
  Tag funAttraction = new Tag(tagNam: "Fun Attraction", tagThm: "Travelling", tagOrd: 3);
  Tag neighborhood = new Tag(tagNam: "Neighborhood", tagThm: "Travelling", tagOrd: 4);
  Tag hotel = new Tag(tagNam: "Hotel", tagThm: "Travelling", tagOrd: 5);
  Tag publicTransport = new Tag(tagNam: "Public Transport", tagThm: "Travelling", tagOrd: 6);
  Tag restaurant = new Tag(tagNam: "Restaurant", tagThm: "Travelling", tagOrd: 7);

   */

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = new DatabaseHelper._privateConstructor();

  //The Database Object we are going to Handle
  static Database _database;

  //This is the database getter associated with the Handler and the Database Object, it initiates the database if it hasn't been initiated already.
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDatabase();
      return _database;
    }
  }

  //This Method is Used to Open a new Database whenever a backup import occurs. It is only called in the settings page.
  openNewDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  //This Method is Used to close the previous Database whenever a backup import occurs. It is only called in the settings page.
  closeDatabase() async {
    Database db = await instance.database;
    _database = null;
    return await db.close();
  }

  //The Database initializer, it opens a database (or the existing one) on the specified path (in this case,getApplicationDocumentsDirectory())
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  //Whenever the Database is upgraded from an old version, this method has to be changed (see examples below)
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    //if it is an upgrade and not a downgrade
    if (oldVersion < newVersion) {}
  }

  //When the Database is created for the first time, this is what should happen:
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $table (
            $columnId INTEGER PRIMARY KEY,
            $columnLatitude REAL,
            $columnLongitude REAL,
            $columnAltitude REAL,
            $columnAccuracy REAL,
            $columnSpeed REAL,
            $columnHeading REAL,
            $columnTimestamp REAL,
            $columnName TEXT,
            $columnSource TEXT,
            $columnTags TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $set_table (
            $columnSettingsId INTEGER PRIMARY KEY,
            $columnLanguage TEXT,
            $columnCoordinates INTEGER,
            $columnUnits INTEGER ,
            $columnStreamFrequency REAL,
            $columnPowerSave INTEGER,
            $columnStoragePath TEXT,
            $columnReceiver INTEGER,
            $columnSound INTEGER,
            $columnNotifications INTEGER,
            $columnScreenTimeout REAL,
            $columnCurrentTheme TEXT,
            $columnDirty INTEGER,
            $columnAutoZoom INTEGER
          )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $tag_table (
            $columnTagId INTEGER PRIMARY KEY,
            $columnTagName TEXT,
            $columnTagOrder INTEGER,
            $columnTagTheme TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $them_table (
            $columnThemId INTEGER PRIMARY KEY,
            $columnThemName TEXT,
            $columnThemSector INTEGER
          )
          ''');
  }

  // ignore: missing_return
  Future manualUpgrade(Database db) {
    db.execute('''
          CREATE TABLE IF NOT EXISTS $tag_table (
            $columnTagId INTEGER PRIMARY KEY,
            $columnTagName TEXT,
            $columnTagOrder INTEGER,
            $columnTagTheme TEXT
          )
          ''');
    db.execute('''
          CREATE TABLE IF NOT EXISTS $them_table (
            $columnThemId INTEGER PRIMARY KEY,
            $columnThemName TEXT,
            $columnThemSector INTEGER
          )
          ''');
  }

  //Inserting a new Waypoint into the Database
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  //Inserting a new Settings Configuration into the Database
  Future<int> insertSettings(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(set_table, row);
  }

  //Inserting a new Tag into the Database
  Future<int> insertTag(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tag_table, row);
  }

  //Inserting a new Theme into the Database
  Future<int> insertTheme(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(them_table, row);
  }

  //Inserting a new Tag as a seed (no prior initialization) into the Database
  Future<int> insertTagSeed(Map<String, dynamic> row) async {
    return await _database.insert(tag_table, row);
  }

  //Inserting a new Theme as a seed (no prior initialization) into the Database
  Future<int> insertThemeSeed(Map<String, dynamic> row) async {
    return await _database.insert(them_table, row);
  }

  //Query (return) all Waypoints
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    var result = await db.query(table);
    return result.toList();
  }

  //Query (return) all Settings Configurations
  Future<List<Map<String, dynamic>>> queryAllRowsSettings() async {
    Database db = await instance.database;
    var result = await db.query(set_table);
    return result.toList();
  }

  //Query (return) all Tags
  Future<List<Map<String, dynamic>>> queryAllRowsTags() async {
    Database db = await instance.database;
    var result = await db.query(tag_table);
    return result.toList();
  }

  //Query (return) all Themes
  Future<List<Map<String, dynamic>>> queryAllRowsThemes() async {
    Database db = await instance.database;
    var result = await db.query(them_table);
    return result.toList();
  }

  //Return number of Waypoints
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  //Return number of Settings Configurations
  Future<int> queryRowCountSettings() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $set_table'));
  }

  //Seed (Populate) the database
  void seed() async {

    DatabaseHelper.instance.insertThemeSeed(geoNames.toMapWithoutId());
    DatabaseHelper.instance.insertThemeSeed(outdoorActivities.toMapWithoutId());
    DatabaseHelper.instance.insertThemeSeed(travelling.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(waterHarbour.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(parksArea.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(cityVillage.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(roadRailroad.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(spotBuilding.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(mountainRock.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(undersea.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(forest.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(hiking.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(running.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(cyclingBiking.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(offroad.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(sailing.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(flying.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(monumentMuseum.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(natureParks.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(funAttraction.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(neighborhood.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(hotel.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(publicTransport.toMapWithoutId());
    DatabaseHelper.instance.insertTagSeed(restaurant.toMapWithoutId());
  }

  //Return number of Tags
  Future<int> queryRowCountTags() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tag_table'));
  }

  //Return number of Themes
  Future<int> queryRowCountThemes() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $them_table'));
  }

  //Update existing Waypoint Object
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  //Update existing Settings Configuration Object
  Future<int> updateSettings(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnSettingsId];
    return await db.update(set_table, row, where: '$columnSettingsId = ?', whereArgs: [id]);
  }

  //Update existing Tag Object
  Future<int> updateTag(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnTagId];
    return await db.update(tag_table, row, where: '$columnTagId = ?', whereArgs: [id]);
  }

  //Update existing Theme Object
  Future<int> updateTheme(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnThemId];
    return await db.update(them_table, row, where: '$columnThemId = ?', whereArgs: [id]);
  }

  //Delete a Waypoint
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  //Delete a Settings Configuration
  Future<int> deleteSettings(int id) async {
    Database db = await instance.database;
    return await db.delete(set_table, where: '$columnSettingsId = ?', whereArgs: [id]);
  }

  //Delete a Tag
  Future<int> deleteTag(int id) async {
    Database db = await instance.database;
    return await db.delete(tag_table, where: '$columnTagId = ?', whereArgs: [id]);
  }

  //Delete a Theme
  Future<int> deleteTheme(int id) async {
    Database db = await instance.database;
    return await db.delete(them_table, where: '$columnThemId = ?', whereArgs: [id]);
  }
}
