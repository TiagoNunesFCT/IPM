import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';



//This Class is what interfaces directly with the SQLite Database (hence it's called DBHandler)
class DBHandler {

  //Database Name File
  static final _databaseName = "ZonexDatabase.db";

  //Database Version. Change This when the database has been modified (eg. columns added, etc.), these changes must be implemented in the onUpgrade Function
  static final _databaseVersion = 1;

  //Users Table
  static final userTable = 'users_table';

  //Settings Table
  static final setTable = 'settings_table';

  //Zones Table
  static final zoneTable = 'zonesTable';

  //Overall Ratings Table
  static final overallRTable = 'overallRatingsTable';

  //Infos Table
  static final infoTable = 'infosTable';

  //Individual Ratings Table
  static final indivRTable = 'individualRatingsTable';

  //Forum Messages Table
  static final forumsTable = 'forumMessagesTable';

  //Crime News Table
  static final crimeTable = 'crimeNewsTable';

  //Names of Columns, grouped by table
  //Users Columns
  static final columnUserId = 'usr_id';
  static final columnUserName = 'usr_name';          //The name won't be unique, since in real life many people can have the same name
  static final columnUserCountry = 'usr_ctr';
  static final columnUserCity = 'usr_cty';
  static final columnUserZone = 'usr_zne';
  static final columnUserDescription = 'usr_desc';
  static final columnUserFriendsString = 'usr_frnd'; //Experimental: a long string containing the IDs of all the User's friends, separated by semicolons (;)
  static final columnUserImage = 'usr_img';          //so we can access the user's photo
  static final columnUserType = 'usr_typ';           //for debug purposes (admin user)


  //Settings Columns
  static final columnSettingsId = 'settings_id';
  static final columnSettingsLanguage = 'settings_lang';
  static final columnSettingsTheme = 'settings_them';
  static final columnSettingsDirty = 'settings_dirty';    //database seeding purposes
  static final columnSettingsAutoZoom = 'settings_zoom';  //map purposes

  //Zones Columns
  static final columnZoneId = 'zon_id';
  static final columnZoneName = 'zon_name';
  static final columnZoneCountry = 'zon_ctr';
  static final columnZoneCity = 'zon_cty';
  static final columnZoneLatitude = 'zon_lat';
  static final columnZoneLongitude = 'zon_lon';

  //Overall Ratings Columns
  static final columnOverallRId = 'ovrt_id';
  static final columnOverallRZone = 'ovrt_zone';
  static final columnOverallROne = 'ovrt_one';        //these 5 are the number of ratings of each star the zone has
  static final columnOverallRTwo = 'ovrt_two';
  static final columnOverallRThree = 'ovrt_tre';
  static final columnOverallRFour = 'ovrt_for';
  static final columnOverallRFive = 'ovrt_fiv';

  //Zone Information Columns
  static final columnInfoId = 'info_id';
  static final columnInfoZone = 'info_zone';
  static final columnInfoType = 'info_type';        //this is a tag that specifies the type of info this is (rent/service/leisure/waterprice, etc)
  static final columnInfoName = 'info_name';        //some infos might have a name, like, for instance, "CTT" or "Pingo Doce"
  static final columnInfoValue = 'info_val';        //the value of that info, can be a string or an int, for instance: rent - int, CTT - closed/open


  //Individual Ratings Columns
  static final columnIndividualRId = 'idrt_id';
  static final columnIndividualRZone = 'idrt_zone';
  static final columnIndividualRUId = 'idrt_uid';        //the id of the user who posted the rating, so we can link directly to their page
  static final columnIndividualRStars = 'idrt_str';      //the numbr of stars in this individual rating
  static final columnIndividualRTimestamp = 'idrt_tst';  //the timestamp of the rating
  static final columnIndividualRDescription = 'idrt_dsc';//the description of the rating

  //Forum Messages Columns
  static final columnForumsId = 'frum_id';
  static final columnForumsZone = 'frum_zone';
  static final columnForumsUId = 'frum_uid';
  static final columnForumsTitle = 'frum_ttl';
  static final columnForumsDesc = 'frum_dsc';
  static final columnForumsReplies = 'frum_rpl';  //Experimental: a long string containing the IDs of all the Posts's replies, separated by semicolons (;)
  static final columnForumsTimestamp = 'idrt_tst';//the timestamp of the post
  static final columnForumsIsReply = 'frum_isr';  //a boolean stating if the post is a reply, if it is, it won't show up on the main list, only in the replies of the original post

  //Crime News Columns Crime News (main key é o id da zona), tem como attrs o nome do canal de notícias, id único, link para o logotipo (ver como fazer), breve descrição da notícia, hyperlink para o artigo (maybe fake), e timestamp
  static final columnCrimeNId = 'crim_id';
  static final columnCrimeNZone = 'crim_zone';
  static final columnCrimeNName = 'crim_name';        //the name of the news outlet
  static final columnCrimeNLogo = 'crim_logo';        //the logo of the news outlet (asset image)
  static final columnCrimeNDesc = 'crim_dsc';         //brief description of the article
  static final columnCrimeNHyper = 'crim_hyp';        //hyperlink for the article
  static final columnCrimeNTimestamp = 'crim_tst';    //the timestamp of the article
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

  DBHandler._privateConstructor();

  static final DBHandler instance = new DBHandler._privateConstructor();

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
          CREATE TABLE IF NOT EXISTS $userTable (
            $columnUserId INTEGER PRIMARY KEY,
            $columnUserName TEXT,
            $columnUserCountry TEXT,
            $columnUserCity TEXT,
            $columnUserZone TEXT,
            $columnUserDescription TEXT,
            $columnUserFriendsString TEXT,
            $columnUserImage TEXT,
            $columnUserType TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $setTable (
            $columnSettingsId INTEGER PRIMARY KEY,
            $columnSettingsLanguage TEXT,
            $columnSettingsTheme TEXT,
            $columnSettingsDirty INTEGER,
            $columnSettingsAutoZoom INTEGER
          )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $zoneTable (
            $columnZoneId INTEGER PRIMARY KEY,
            $columnZoneName TEXT,
            $columnZoneCountry TEXT,
            $columnZoneCity TEXT,
            $columnZoneLatitude REAL,
            $columnZoneLongitude REAL
          )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $overallRTable (
            $columnOverallRId INTEGER PRIMARY KEY,
            $columnOverallRZone INTEGER,
            $columnOverallROne INTEGER,
            $columnOverallRTwo INTEGER,
            $columnOverallRThree INTEGER,
            $columnOverallRFour INTEGER,
            $columnOverallRFive INTEGER
          )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $infoTable (
            $columnInfoId INTEGER PRIMARY KEY,
            $columnInfoZone INTEGER,
            $columnInfoType TEXT,
            $columnInfoName TEXT,
            $columnInfoValue TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $indivRTable (
            $columnIndividualRId INTEGER PRIMARY KEY,
            $columnIndividualRZone INTEGER,
            $columnIndividualRUId INTEGER,
            $columnIndividualRStars INTEGER,
            $columnIndividualRTimestamp TEXT,
            $columnIndividualRDescription TEXT
          )
          ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS $forumsTable (
            $columnForumsId INTEGER PRIMARY KEY,
            $columnForumsZone INTEGER,
            $columnForumsUId INTEGER,
            $columnForumsTitle TEXT,
            $columnForumsDesc TEXT,
            $columnForumsReplies TEXT,
            $columnForumsTimestamp TEXT,
            $columnForumsIsReply INTEGER
          )
          ''');

    await db.execute('''
          CREATE TABLE IF NOT EXISTS $crimeTable (
            $columnCrimeNId INTEGER PRIMARY KEY,
            $columnCrimeNZone INTEGER,
            $columnCrimeNName TEXT,
            $columnCrimeNLogo TEXT,
            $columnCrimeNDesc TEXT,
            $columnCrimeNHyper TEXT,
            $columnCrimeNTimestamp TEXT
          )
          ''');
  }

  //Inserting a new User into the Database
  Future<int> insertUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(userTable, row);
  }

  //Inserting a new Settings Configuration into the Database
  Future<int> insertSettings(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(setTable, row);
  }

  //Inserting a new Zone into the Database
  Future<int> insertZone(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(zoneTable, row);
  }

  //Inserting a new Overall Ratings object into the Database
  Future<int> insertOverallR(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(overallRTable, row);
  }

  //Inserting a new piece of Information into the Database
  Future<int> insertInfo(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(infoTable, row);
  }

  //Inserting a new Individual Ratings object into the Database
  Future<int> insertIndividualR(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(indivRTable, row);
  }

  //Inserting a new Forums Post into the Database
  Future<int> insertForums(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(forumsTable, row);
  }

  //Inserting a new Crime News Article into the Database
  Future<int> insertCrime(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(crimeTable, row);
  }

  //Inserting a new User as a seed (no prior initialization) into the Database
  Future<int> insertUserSeed(Map<String, dynamic> row) async {
    return await _database.insert(userTable, row);
  }

  //Inserting a new Settings configuration as a seed (no prior initialization) into the Database
  Future<int> insertSettingsSeed(Map<String, dynamic> row) async {
    return await _database.insert(setTable, row);
  }

  //Inserting a new Zone as a seed (no prior initialization) into the Database
  Future<int> insertZoneSeed(Map<String, dynamic> row) async {
    return await _database.insert(zoneTable, row);
  }

  //Inserting a new Overall Ratings Object as a seed (no prior initialization) into the Database
  Future<int> insertOverallRSeed(Map<String, dynamic> row) async {
    return await _database.insert(overallRTable, row);
  }

  //Inserting a new piece of Information as a seed (no prior initialization) into the Database
  Future<int> insertInfoSeed(Map<String, dynamic> row) async {
    return await _database.insert(infoTable, row);
  }

  //Inserting a new Settings configuration as a seed (no prior initialization) into the Database
  Future<int> insertIndividualRSeed(Map<String, dynamic> row) async {
    return await _database.insert(indivRTable, row);
  }

  //Inserting a new Forums Post as a seed (no prior initialization) into the Database
  Future<int> insertForumsSeed(Map<String, dynamic> row) async {
    return await _database.insert(forumsTable, row);
  }

  //Inserting a new Crime News Article as a seed (no prior initialization) into the Database
  Future<int> insertCrimeSeed(Map<String, dynamic> row) async {
    return await _database.insert(crimeTable, row);
  }

  //Query (return) all Users
  Future<List<Map<String, dynamic>>> queryAllRowsUsers() async {
    Database db = await instance.database;
    var result = await db.query(userTable);
    return result.toList();
  }

  //Query (return) all Settings Configurations
  Future<List<Map<String, dynamic>>> queryAllRowsSettings() async {
    Database db = await instance.database;
    var result = await db.query(setTable);
    return result.toList();
  }

  //Query (return) all Zones
  Future<List<Map<String, dynamic>>> queryAllRowsZones() async {
    Database db = await instance.database;
    var result = await db.query(zoneTable);
    return result.toList();
  }

  //Query (return) all Overall Ratings Objects
  Future<List<Map<String, dynamic>>> queryAllRowsOverallR() async {
    Database db = await instance.database;
    var result = await db.query(overallRTable);
    return result.toList();
  }

  //Query (return) all pieces of information
  Future<List<Map<String, dynamic>>> queryAllRowsInfo() async {
    Database db = await instance.database;
    var result = await db.query(infoTable);
    return result.toList();
  }

  //Query (return) all Individual Rating Objects
  Future<List<Map<String, dynamic>>> queryAllRowsIndividualR() async {
    Database db = await instance.database;
    var result = await db.query(indivRTable);
    return result.toList();
  }

  //Query (return) all Forum Posts
  Future<List<Map<String, dynamic>>> queryAllRowsForums() async {
    Database db = await instance.database;
    var result = await db.query(forumsTable);
    return result.toList();
  }

  //Query (return) all Crime News
  Future<List<Map<String, dynamic>>> queryAllRowsCrime() async {
    Database db = await instance.database;
    var result = await db.query(crimeTable);
    return result.toList();
  }

  //Return number of Users
  Future<int> queryRowCountUsers() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $userTable'));
  }

  //Return number of Settings Configurations
  Future<int> queryRowCountSettings() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $setTable'));
  }

  //Return number of Zones
  Future<int> queryRowCountZones() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $zoneTable'));
  }

  //Return number of OverallRatings
  Future<int> queryRowCountOverallR() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $overallRTable'));
  }

  //Return number of Pieces of Information
  Future<int> queryRowCountInfos() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $infoTable'));
  }

  //Return number of IndividualRatings
  Future<int> queryRowCountIndividualR() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $indivRTable'));
  }

  //Return number of Forum Messages
  Future<int> queryRowCountForums() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $forumsTable'));
  }

  //Return number of Crime News Articles
  Future<int> queryRowCountCrimes() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $crimeTable'));
  }


  //Seed (Populate) the database
  void seed() async {

    /**
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
        **/
  }

  //Update existing User Object
  Future<int> updateUser(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnUserId];
    return await db.update(userTable, row, where: '$columnUserId = ?', whereArgs: [id]);
  }

  //Update existing Settings Configuration Object
  Future<int> updateSettings(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnSettingsId];
    return await db.update(setTable, row, where: '$columnSettingsId = ?', whereArgs: [id]);
  }

  //Update existing Zone Object
  Future<int> updateZone(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnZoneId];
    return await db.update(zoneTable, row, where: '$columnZoneId = ?', whereArgs: [id]);
  }

  //Update existing Overall Rankings Object
  Future<int> updateOverallR(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnOverallRId];
    return await db.update(overallRTable, row, where: '$columnOverallRId = ?', whereArgs: [id]);
  }

  //Update existing Info Object
  Future<int> updateInfo(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnInfoId];
    return await db.update(infoTable, row, where: '$columnInfoId = ?', whereArgs: [id]);
  }

  //Update existing Individual Ratings Object
  Future<int> updateIndividualR(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnIndividualRId];
    return await db.update(indivRTable, row, where: '$columnIndividualRId = ?', whereArgs: [id]);
  }

  //Update existing Forum Post Object
  Future<int> updateForum(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnForumsId];
    return await db.update(forumsTable, row, where: '$columnForumsId = ?', whereArgs: [id]);
  }

  //Update existing Crime News Article Object
  Future<int> updateCrime(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnCrimeNId];
    return await db.update(crimeTable, row, where: '$columnCrimeNId = ?', whereArgs: [id]);
  }

  //Delete a User
  Future<int> deleteUser(int id) async {
    Database db = await instance.database;
    return await db.delete(userTable, where: '$columnUserId = ?', whereArgs: [id]);
  }

  //Delete a Settings Configuration
  Future<int> deleteSettings(int id) async {
    Database db = await instance.database;
    return await db.delete(setTable, where: '$columnSettingsId = ?', whereArgs: [id]);
  }

  //Delete a Zone
  Future<int> deleteZone(int id) async {
    Database db = await instance.database;
    return await db.delete(zoneTable, where: '$columnZoneId = ?', whereArgs: [id]);
  }

  //Delete an Overall Ratings Object
  Future<int> deleteOverallR(int id) async {
    Database db = await instance.database;
    return await db.delete(overallRTable, where: '$columnOverallRId = ?', whereArgs: [id]);
  }

  //Delete a piece of Information
  Future<int> deleteInfo(int id) async {
    Database db = await instance.database;
    return await db.delete(infoTable, where: '$columnInfoId = ?', whereArgs: [id]);
  }

  //Delete an Individual Ratings object
  Future<int> deleteIndividualR(int id) async {
    Database db = await instance.database;
    return await db.delete(indivRTable, where: '$columnIndividualRId = ?', whereArgs: [id]);
  }

  //Delete a Forums Post
  Future<int> deleteForum(int id) async {
    Database db = await instance.database;
    return await db.delete(forumsTable, where: '$columnForumsId = ?', whereArgs: [id]);
  }

  //Delete a Crime News Article
  Future<int> deleteTheme(int id) async {
    Database db = await instance.database;
    return await db.delete(crimeTable, where: '$columnCrimeNId = ?', whereArgs: [id]);
  }
}
