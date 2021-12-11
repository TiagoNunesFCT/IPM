import 'package:flutter/cupertino.dart';
import 'package:zone/Database/dbHandler.dart';
import 'package:zone/datatypes/settingsObject.dart';

//This is a settings list. It currently has no functionality but it has been built with multiple distinct settings configurations in mind

List<Settings> listSettings = [];

int currentLocId = 0;

//These are the default values for all the settings when the app is loaded for the first time and there is no data

Settings currentSettings;
String currentLanguage = "English";
String currentTheme = "Dark";
int dbDirty = 0;
int autoZoom = 0;
bool dbEmpty = true;


//This common page class is the superclass of almost all pages. It contains methods that are used in more than one page, therefore reducing code redundancy
// ignore: must_be_immutable
abstract class GenericPage extends StatefulWidget {

  //It is a stateful page
  GenericPageState createState() => new GenericPageState();
}

//The Page State
class GenericPageState extends State<GenericPage> {


  //This applies the current settings to the page's content


  Future<void> applySettings() async {
    //It fetches the settings from the database
    List<Map<String, dynamic>> listMap = await DBHandler.instance.queryAllRowsSettings();
    setState(() {
      listMap.forEach((map) => putInFirst(Settings.fromMap(map)));
    });

    //If there are no settings, it's going to create a new settings configuration and upload it to the database
    if (listSettings.isEmpty) {
      Settings defaultSettings = new Settings(settingsId: 1, settingsLang: currentLanguage, settingsThem: currentTheme, settingsDirty: dbDirty, settingsZoom: autoZoom);
      putInFirst(defaultSettings);
      //This dbDirty allows for an effective theme seeding. It pretty much establishes that the database is no longer uninitialized, and that is has been modified for the first time, therefore it can be seeded
      dbDirty = 1;
      //Updates the settings
      updateSettings();
      //Seed the database
      DBHandler.instance.seed();
    } else {
      //the database is not empty, so we're going to import the existing settings
      dbEmpty = false;
      Settings currentSettings = listSettings.first;
      currentLanguage = currentSettings.settingsLang;
      currentTheme = (currentSettings.settingsThem == null) ? "Dark" : currentSettings.settingsThem;
      dbDirty = currentSettings.settingsDirty;
      autoZoom = currentSettings.settingsZoom;
    }
    //the current settings will be the first of the list
    currentSettings = listSettings.first;
  }

  //The method that updates the settings present in the database
  Future<void> updateSettings() async {
    //The settings object we're going to use in the database
    Settings updateSettings = new Settings(settingsId: 1, settingsLang: currentLanguage, settingsThem: currentTheme, settingsDirty: dbDirty, settingsZoom: autoZoom);

    //since in this version there is only one settings configuration on the settings list, we call the Put In First method to ensure the list is clean
    putInFirst(updateSettings);

    //If there's already a settings object in the database, we're going to update it, otherwise we insert it as a new one
    if (!dbEmpty) {
      await DBHandler.instance.updateSettings(updateSettings.toMap());
    } else {
      await DBHandler.instance.insertSettings(updateSettings.toMapWithoutId());
      dbEmpty = false;
    }
  }

  //Clears and Inserts the Settings object as the first one on the List
  void putInFirst(Settings set) {
    listSettings.clear();
    listSettings.add(set);
  }

  //This is an abstract class. As such, the widget build returns null
  @override
  Widget build(BuildContext context) {
    return null;
  }

  //The common pages apply their settings on the fly, on the init state method, to ensure it's always updated
  /*void initState() {
    applySettings();
    super.initState();
  }*/

  //Unit Conversion Methods

  // ignore: non_constant_identifier_names
  double MetersToFeet(double meters) {
    return meters * 3.280840;
  }

  // ignore: non_constant_identifier_names
  double FeetToMeters(double feet) {
    return feet / 3.280840;
  }
}
