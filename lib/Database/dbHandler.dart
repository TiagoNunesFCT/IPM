import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zone/datatypes/crimeNewsObject.dart';
import 'package:zone/datatypes/forumPostObject.dart';
import 'package:zone/datatypes/individualRObject.dart';
import 'package:zone/datatypes/infoObject.dart';
import 'package:zone/datatypes/overallRObject.dart';
import 'package:zone/datatypes/userObject.dart';
import 'package:zone/datatypes/zoneObject.dart';



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
  static final columnForumsTimestamp = 'frum_tst';//the timestamp of the post
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

  //users

  User userOurs = new User(usrId: 0,usrNam:"Username", usrCtr: "🇵🇹", usrCty: "Almada", usrZne: "Laranjeiro e Feijó", usrDsc: "Hello, I just Joined the App!", usrImg: "default", usrFnd: "", usrTyp: "normal");
  User userRicardo = new User(usrId: 1,usrNam:"Ricardo Teixeira", usrCtr: "🇵🇹", usrCty: "Almada", usrZne: "Laranjeiro e Feijó", usrDsc: "👺", usrImg: "default", usrFnd: "", usrTyp: "admin");
  User userPedro = new User(usrId: 2,usrNam:"Pedro Micaelo", usrCtr: "🇵🇹", usrCty: "Seixal", usrZne: "Corroios", usrDsc: "🥶", usrImg: "default", usrFnd: "", usrTyp: "admin");
  User userTiago = new User(usrId: 3,usrNam:"Tiago Nunes", usrCtr: "🇵🇹", usrCty: "Almada", usrZne: "Laranjeiro e Feijó", usrDsc: "Greetings, earthling", usrImg: "default", usrFnd: "", usrTyp: "admin");
  User userOther = new User(usrId: 4,usrNam:"Sabrina Ribas", usrCtr: "🇵🇹", usrCty: "Almada", usrZne: "Caparica e Trafaria", usrDsc: "Hello, I just Joined the App!", usrImg: "default", usrFnd: "", usrTyp: "normal");

  //zones

  Zone laranFeij = new Zone(zoneId: 0,zoneNam: "Laranjeiro e Feijó", zoneLat: 38.657, zoneLon: -9.15, zoneCtr: "🇵🇹", zoneCty: "Almada");
  Zone capTraf = new Zone(zoneId: 1,zoneNam: "Caparica e Trafaria", zoneLat: 38.663, zoneLon: -9.215, zoneCtr: "🇵🇹", zoneCty: "Almada");

  //overall ratings

  OverallR overallLF = new OverallR(overRZon: 0, overROne: 13, overRTwo: 40, overRTre: 32, overRFor: 5, overRFiv: 10);
  OverallR overallCT = new OverallR(overRZon: 1, overROne: 70, overRTwo: 10, overRTre: 15, overRFor: 3, overRFiv: 2);

  //infos laranjeiro e feijó

  Info waterpriceLF = new Info(infoZone: 0, infoTyp: "prices", infoNam: "Water price (l)", infoVal: "0,35€");
  Info gaspriceLF = new Info(infoZone: 0, infoTyp: "prices", infoNam: "Gas price (m³)", infoVal: "0,64€");
  Info elecpriceLF = new Info(infoZone: 0, infoTyp: "prices", infoNam: "Electricity price (kWh)", infoVal: "0,69€");
  Info rentpriceLF = new Info(infoZone: 0, infoTyp: "prices", infoNam: "Rent (avg)", infoVal: "42€");

  Info cttLF = new Info(infoZone: 0, infoTyp: "service", infoNam: "CTT", infoVal: "Closed");
  Info balcfinLF = new Info(infoZone: 0, infoTyp: "service", infoNam: "Balcão das Finanças", infoVal: "Open");
  Info juntaLF = new Info(infoZone: 0, infoTyp: "service", infoNam: "Junta de Freguesia", infoVal: "Open");

  Info tst1LF = new Info(infoZone: 0, infoTyp: "transport", infoNam: "TST - Rua João Cardoso", infoVal: "");
  Info tst2LF = new Info(infoZone: 0, infoTyp: "transport", infoNam: "TST - Avenida 25 de Abril", infoVal: "");
  Info tst3LF = new Info(infoZone: 0, infoTyp: "transport", infoNam: "TST - Alameda Rui Simões", infoVal: "");
  Info mts1LF = new Info(infoZone: 0, infoTyp: "transport", infoNam: "MTS - António Gedeão", infoVal: "");
  Info mts2LF = new Info(infoZone: 0, infoTyp: "transport", infoNam: "MTS - Laranjeiro", infoVal: "");

  Info pingoDoceLF = new Info(infoZone: 0, infoTyp: "shopping", infoNam: "Pingo Doce", infoVal: "Open");
  Info aldiLF = new Info(infoZone: 0, infoTyp: "shopping", infoNam: "Aldi", infoVal: "Closed");

  Info tourismLF = new Info(infoZone: 0, infoTyp: "tourism", infoNam: "None", infoVal: "");

  Info parkLF = new Info(infoZone: 0, infoTyp: "leisure", infoNam: "Parque da Paz", infoVal: "");

  //infos caparica e trafaria

  Info waterpriceCT = new Info(infoZone: 1, infoTyp: "prices", infoNam: "Water price (l)", infoVal: "0,35€");
  Info gaspriceCT = new Info(infoZone: 1, infoTyp: "prices", infoNam: "Gas price (m³)", infoVal: "0,45€");
  Info elecpriceCT = new Info(infoZone: 1, infoTyp: "prices", infoNam: "Electricity price (kWh)", infoVal: "0,37€");
  Info rentpriceCT = new Info(infoZone: 1, infoTyp: "prices", infoNam: "Rent (avg)", infoVal: "56€");

  Info cttCT = new Info(infoZone: 1, infoTyp: "service", infoNam: "CTT", infoVal: "Open");
  Info balcfinCT = new Info(infoZone: 1, infoTyp: "service", infoNam: "Balcão das Finanças", infoVal: "Open");
  Info juntaCT = new Info(infoZone: 1, infoTyp: "service", infoNam: "Junta de Freguesia", infoVal: "Closed");

  Info tst1CT = new Info(infoZone: 1, infoTyp: "transport", infoNam: "TST - Rua Trabalhadores Rurais", infoVal: "");
  Info tst2CT = new Info(infoZone: 1, infoTyp: "transport", infoNam: "TST - Rua Con M Fernandes", infoVal: "");
  Info mts1CT = new Info(infoZone: 1, infoTyp: "transport", infoNam: "MTS - Fomega", infoVal: "");
  Info mts2CT = new Info(infoZone: 1, infoTyp: "transport", infoNam: "MTS - Monte da Caparica", infoVal: "");

  Info jumboCT = new Info(infoZone: 1, infoTyp: "shopping", infoNam: "Jumbo", infoVal: "Open");
  Info aldiCT = new Info(infoZone: 1, infoTyp: "shopping", infoNam: "Aldi", infoVal: "Closed");

  Info tourismCT = new Info(infoZone: 1, infoTyp: "tourism", infoNam: "Cova do vapor", infoVal: "");

  Info parkCT = new Info(infoZone: 1, infoTyp: "leisure", infoNam: "Praia da Fonte da Telha", infoVal: "");

  //individual ratings

  IndividualR indivR1LF = new IndividualR(indiRZone: 0, indiRUId: 3, indiRStr: 5, indiRTim: "1/3/2023", indiRDsc: "Boa Zona, Margem Sul Represents!");
  IndividualR indivR2LF = new IndividualR(indiRZone: 0, indiRUId: 1, indiRStr: 2, indiRTim: "3/4/2023", indiRDsc: "Fui Assaltado! Baixo nível de segurança 🥶");
  IndividualR indivR3LF = new IndividualR(indiRZone: 0, indiRUId: 2, indiRStr: 3, indiRTim: "23/2/2023", indiRDsc: "Zona Fixe mas os Cabeleireiros cortaram-me a cabeça!👺");

  IndividualR indivR1CT = new IndividualR(indiRZone: 1, indiRUId: 3, indiRStr: 5, indiRTim: "5/4/2023", indiRDsc: "Adoro a zona, boas paisagens");
  IndividualR indivR2CT = new IndividualR(indiRZone: 1, indiRUId: 1, indiRStr: 2, indiRTim: "9/10/2023", indiRDsc: "Zona questionável");
  IndividualR indivR3CT = new IndividualR(indiRZone: 1, indiRUId: 2, indiRStr: 4, indiRTim: "12/3/2023", indiRDsc: "Fácil movimentação na área, pessoal simpático");

  //posts LF
  
  ForumPost post1LF = new ForumPost(forumZone: 0, forumUId: 3, forumTtl: "À Venda - Ford Sierra 1982", forumDsc: "Viatura em bom estado, versão RS Cosworth bastante procurada. 23000€", forumRep: "", forumTst: "23/5/2023", forumIsR: 0);
  ForumPost post2LF = new ForumPost(forumZone: 0, forumUId: 2, forumTtl: "Dentistas na Zona?", forumDsc: "Estou à procura de uma clínica dentária que não seja desnecessariamente cara.", forumRep: "", forumTst: "14/4/2023", forumIsR: 0);
  ForumPost post3LF = new ForumPost(forumZone: 0, forumUId: 4, forumTtl: "Compro T2 Laranjeiro", forumDsc: "Mudei-me recentemente para a zona e estou a viver num apartamento alugado. Procuro uma casa definitiva mas não muito cara.", forumRep: "", forumTst: "18/9/2023", forumIsR: 0);

  //posts CT

  ForumPost post1CT = new ForumPost(forumZone: 1, forumUId: 3, forumTtl: "Compro - Jogos playstation 2", forumDsc: "Compro todo o tipo de jogos para a ps2, preço negociável", forumRep: "", forumTst: "23/6/2023", forumIsR: 0);
  ForumPost post2CT = new ForumPost(forumZone: 1, forumUId: 2, forumTtl: "Procuro - Praias family friendly", forumDsc: "Gostava que me sugerissem uma praia boa para levar a familia, sem grandes confusoes e pouca gente", forumRep: "", forumTst: "23/11/2023", forumIsR: 0);
  ForumPost post3CT = new ForumPost(forumZone: 1, forumUId: 1, forumTtl: "Procuro amigos", forumDsc: "Sou novo por aqui gostava de conhecer pessoas novas 🙂", forumRep: "", forumTst: "23/11/2023", forumIsR: 0);


  //crime news LF
  
  CrimeN crime1LF = new CrimeN(crimeNZone: 0, crimeNNam: "Correio da Manhã", crimeNLogo: "", crimeNDsc: "Sujeito morre eletrocutado no Feijó, mãe chocada", crimeNHyp: "https://www.google.com", crimeNTst: "12/1/2023");
  CrimeN crime2LF = new CrimeN(crimeNZone: 0, crimeNNam: "Público", crimeNLogo: "", crimeNDsc: "Criminalidade aumenta 14% no Laranjeiro e 3% no Feijó", crimeNHyp: "https://www.google.com", crimeNTst: "28/2/2023");
  CrimeN crime3LF = new CrimeN(crimeNZone: 0, crimeNNam: "Rúbrica do Feijó", crimeNLogo: "", crimeNDsc: "Tiroteio no Chegadinho faz 5 mortos", crimeNHyp: "https://www.google.com", crimeNTst: "12/1/2023");

  //crime news CT
  CrimeN crime1CT = new CrimeN(crimeNZone: 1, crimeNNam: "Correio da Manhã", crimeNLogo: "", crimeNDsc: "Rapaz de 23 anos esfaqueado à porta do metro na estação da Fomega", crimeNHyp: "https://www.google.com/", crimeNTst: "12/1/2023");
  CrimeN crime2CT = new CrimeN(crimeNZone: 1, crimeNNam: "Expresso", crimeNLogo: "", crimeNDsc: "Gangues perigosos formados na FCT voltam a atacar", crimeNHyp: "https://www.google.com/", crimeNTst: "28/8/2023");
  CrimeN crime3CT = new CrimeN(crimeNZone: 1, crimeNNam: "Jornal da caparica", crimeNLogo: "", crimeNDsc: "Conflitos organizados entre bairros", crimeNHyp: "https://www.google.com/", crimeNTst: "12/5/2023");



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

  Future<List<Map<String, dynamic>>> querySpecificInfos(String zoneId) async {
    Database db = await instance.database;
    var result = await db.rawQuery('SELECT * FROM $infoTable WHERE $columnInfoZone = ?',['$zoneId']);
    return result.toList();
  }

  Future<List<Map<String, dynamic>>> querySpecificPosts(String zoneId) async {
    Database db = await instance.database;
    var result = await db.rawQuery('SELECT * FROM $forumsTable WHERE $columnForumsZone = ?',['$zoneId']);
    return result.toList();
  }

  Future<List<Map<String, dynamic>>> querySpecificIRatings(String zoneId) async {
    Database db = await instance.database;
    var result = await db.rawQuery('SELECT * FROM $indivRTable WHERE $columnIndividualRZone = ?',['$zoneId']);
    return result.toList();
  }

  Future<List<Map<String, dynamic>>> queryIndividualUser(String userId) async {
    Database db = await instance.database;
    var result = await db.rawQuery('SELECT * FROM $userTable WHERE $columnUserId = ?',['$userId']);
    return result.toList();
  }


  //Seed (Populate) the database
  void seed() async {

    DBHandler.instance.insertUserSeed(userOurs.toMap());
    DBHandler.instance.insertUserSeed(userRicardo.toMap());
    DBHandler.instance.insertUserSeed(userPedro.toMap());
    DBHandler.instance.insertUserSeed(userTiago.toMap());
    DBHandler.instance.insertUserSeed(userOther.toMap());

    DBHandler.instance.insertZoneSeed(laranFeij.toMap());
    DBHandler.instance.insertZoneSeed(capTraf.toMap());

    DBHandler.instance.insertOverallRSeed(overallLF.toMapWithoutId());
    DBHandler.instance.insertOverallRSeed(overallCT.toMapWithoutId());

    DBHandler.instance.insertInfoSeed(waterpriceLF.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(gaspriceLF.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(elecpriceLF.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(rentpriceLF.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(cttLF.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(balcfinLF.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(juntaLF.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(tst1LF.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(tst2LF.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(tst3LF.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(mts1LF.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(mts2LF.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(pingoDoceLF.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(aldiLF.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(tourismLF.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(parkLF.toMapWithoutId());

    DBHandler.instance.insertInfoSeed(waterpriceCT.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(gaspriceCT.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(elecpriceCT.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(rentpriceCT.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(cttCT.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(balcfinCT.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(juntaCT.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(tst1CT.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(tst2CT.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(mts1CT.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(mts2CT.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(jumboCT.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(aldiCT.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(tourismCT.toMapWithoutId());
    DBHandler.instance.insertInfoSeed(parkCT.toMapWithoutId());


    DBHandler.instance.insertIndividualRSeed(indivR1LF.toMapWithoutId());
    DBHandler.instance.insertIndividualRSeed(indivR2LF.toMapWithoutId());
    DBHandler.instance.insertIndividualRSeed(indivR3LF.toMapWithoutId());
    DBHandler.instance.insertIndividualRSeed(indivR1CT.toMapWithoutId());
    DBHandler.instance.insertIndividualRSeed(indivR2CT.toMapWithoutId());
    DBHandler.instance.insertIndividualRSeed(indivR3CT.toMapWithoutId());

    DBHandler.instance.insertForumsSeed(post1LF.toMapWithoutId());
    DBHandler.instance.insertForumsSeed(post2LF.toMapWithoutId());
    DBHandler.instance.insertForumsSeed(post3LF.toMapWithoutId());
    DBHandler.instance.insertForumsSeed(post1CT.toMapWithoutId());
    DBHandler.instance.insertForumsSeed(post2CT.toMapWithoutId());
    DBHandler.instance.insertForumsSeed(post3CT.toMapWithoutId());

    DBHandler.instance.insertCrimeSeed(crime1LF.toMapWithoutId());
    DBHandler.instance.insertCrimeSeed(crime2LF.toMapWithoutId());
    DBHandler.instance.insertCrimeSeed(crime3LF.toMapWithoutId());
    DBHandler.instance.insertCrimeSeed(crime1CT.toMapWithoutId());
    DBHandler.instance.insertCrimeSeed(crime2CT.toMapWithoutId());
    DBHandler.instance.insertCrimeSeed(crime3CT.toMapWithoutId());

    debugPrint("Seeding Done");

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
