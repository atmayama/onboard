import 'package:gullak/data/model/preference.dart';
import 'package:gullak/external/local/preference.dart';
import 'package:gullak/external/local/user.dart';
import 'package:gullak/external/network/api.dart';

import 'model/user.dart';

Future<User?> getLogInUser() async {
  return getUserId().then((id) {
    return getUser(id).then((i) => i);
  });
}

Future<AppPreference> getAppPreferences() async {
  return getPreference();
}
