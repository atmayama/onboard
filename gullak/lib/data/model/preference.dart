import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

class AppPreference {
  ThemeMode theme = ThemeMode.system;

  AppPreference(this.theme);

  AppPreference.fromMap(Map<String, dynamic>? map) {
    if (map != null) {
      theme = map['theme'] == "light" ? ThemeMode.light : ThemeMode.dark;
    }
  }
}
