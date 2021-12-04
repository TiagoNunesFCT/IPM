import 'package:flutter/cupertino.dart';

//This class represents a Settings Configuration object
class Settings {
  //The Current Settings Attributes (or Individual Settings)
  int settingsId, settingsDirty, settingsZoom;
  String settingsLang, settingsThem;

  Settings({this.settingsId, @required this.settingsLang, @required this.settingsThem, @required this.settingsDirty, @required this.settingsZoom});

  //to be used when inserting a row in the table
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["settings_lang"] = settingsLang;
    map["settings_them"] = settingsThem;
    map["settings_dirty"] = settingsDirty;
    map["settings_zoom"] = settingsZoom;
    return map;
  }

  //to be used when updating a row in the table
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["settings_id"] = settingsId;
    map["settings_lang"] = settingsLang;
    map["settings_them"] = settingsThem;
    map["settings_dirty"] = settingsDirty;
    map["settings_zoom"] = settingsZoom;
    return map;
  }

  //to be used when converting the row into object
  factory Settings.fromMap(Map<String, dynamic> data) => new Settings(
        settingsId: data["settings_id"],
        settingsLang: data["settings_lang"],
        settingsThem: data["settings_them"],
        settingsDirty: data["settings_dirty"],
        settingsZoom: data["settings_zoom"],
      );
}
