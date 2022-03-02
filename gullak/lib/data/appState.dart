import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gullak/data/creators.dart';
import 'package:gullak/data/model/preference.dart';

import 'model/user.dart';

class AppState with ChangeNotifier {
  AppPreference? _appPreference;
  User? _user;

  AppState() {
    load();
  }

  AppState.from(this._user, this._appPreference);

  AppPreference? get appPreference => _appPreference;

  set appPreference(AppPreference? value) {
    _appPreference = value;
    notifyListeners();
  }

  User? get user => _user;

  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  Future load() async {
    _user = await getLogInUser();
    _appPreference = await getAppPreferences();
    notifyListeners();
  }

  void refresh() {
    load().then((value) {
      stdout.writeln("reloading app state");
      notifyListeners();
    });
  }
}
