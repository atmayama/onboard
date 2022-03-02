import 'dart:io';

import 'package:gullak/data/model/preference.dart';
import 'package:gullak/external/local/preference.dart';
import 'package:gullak/external/local/user.dart';
import 'package:gullak/external/network/api.dart';

import 'model/user.dart';

Future<User?> getLogInUser() async {
  return await getUserId().then((id) {
    stdout.write("logged in user: " + id.toString());
    return (id == null || id.isEmpty) ? Future.value(null) : getUser(id);
  }).catchError((error) {
    stdout.writeln(error);
    return Future.value(null);
  });
}

Future<AppPreference> getAppPreferences() async {
  return getPreference();
}
