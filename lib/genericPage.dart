import 'package:flutter/cupertino.dart';

//This is a settings list. It currently has no functionality but it has been built with multiple distinct settings configurations in mind


//List<Settings> listSettings = [];

//These are the default values for all the settings when the app is loaded for the first time and there is no data

//Settings currentSettings;
String currentTheme = "GeoNames";


//This common page class is the superclass of almost all pages. It contains methods that are used in more than one page, therefore reducing code redundancy
// ignore: must_be_immutable
abstract class GenericPage extends StatefulWidget {

  //It is a stateful page
  GenericPageState createState() => new GenericPageState();
}

//The Page State
class GenericPageState extends State<GenericPage> {
  //This applies the current settings (such as units, coordinate systems, and auto-zoom) to the page's content


  /*Future<void> applySettings() async {
    //It fetches the settings from the database
    List<Map<String, dynamic>> listMap = await DatabaseHelper.instance.queryAllRowsSettings();
    setState(() {
      listMap.forEach((map) => putInFirst(Settings.fromMap(map)));
    });

    //If there are no settings, it's going to create a new settings configuration and upload it to the database
    if (listSettings.isEmpty) {
      Settings defaultSettings = new Settings(settingsId: 1, settingsLang: langValue, settingsCoord: coordValue, settingsUnit: unitValue, settingsFreq: freqValue, settingsPower: powerValue, settingsStor: storValue, settingsRecv: recvValue, settingsSnd: sndValue, settingsNote: noteValue, settingsTim: timValue, settingsCur: currentTheme, settingsDirty: dbDirty, settingsZoom: autoZoom);
      putInFirst(defaultSettings);
      //This dbDirty allows for an effective theme seeding. It pretty much establishes that the database is no longer uninitialized, and that is has been modified for the first time, therefore it can be seeded
      dbDirty = 1;
      //Updates the settings
      updateSettings();
      //Seed the database
      DatabaseHelper.instance.seed();
    } else {
      //the database is not empty, so we're going to import the existing settings
      dbEmpty = false;
      Settings currentSettings = listSettings.first;
      langValue = currentSettings.settingsLang;
      coordValue = currentSettings.settingsCoord;
      unitValue = currentSettings.settingsUnit;
      freqValue = currentSettings.settingsFreq;
      powerValue = currentSettings.settingsPower;
      storValue = currentSettings.settingsStor;
      recvValue = currentSettings.settingsRecv;
      sndValue = currentSettings.settingsSnd;
      noteValue = currentSettings.settingsNote;
      timValue = currentSettings.settingsTim;
      idValue = currentSettings.settingsId;
      currentTheme = (currentSettings.settingsCur == null) ? "GeoNames" : currentSettings.settingsCur;
      dbDirty = currentSettings.settingsDirty;
      autoZoom = currentSettings.settingsZoom;
    }
    //the current settings will be the first of the list
    currentSettings = listSettings.first;
  }
  */

  //The method that updates the settings present in the database
  /*Future<void> updateSettings() async {
    //The settings object we're going to use in the database
    Settings updateSettings = new Settings(settingsId: 1, settingsLang: langValue, settingsCoord: coordValue, settingsUnit: unitValue, settingsFreq: freqValue, settingsPower: powerValue, settingsStor: storValue, settingsRecv: recvValue, settingsSnd: sndValue, settingsNote: noteValue, settingsTim: timValue, settingsCur: currentTheme, settingsDirty: dbDirty, settingsZoom: autoZoom);

    //since in this version there is only one settings configuration on the settings list, we call the Put In First method to ensure the list is clean
    putInFirst(updateSettings);

    //If there's already a settings object in the database, we're going to update it, otherwise we insert it as a new one
    if (!dbEmpty) {
      await DatabaseHelper.instance.updateSettings(updateSettings.toMap());
    } else {
      await DatabaseHelper.instance.insertSettings(updateSettings.toMapWithoutId());
      dbEmpty = false;
    }
  }*/

  //Clears and Inserts the Settings object as the first one on the List
  /*void putInFirst(Settings set) {
    listSettings.clear();
    listSettings.add(set);
  }*/

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
