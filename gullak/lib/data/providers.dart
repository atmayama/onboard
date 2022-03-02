import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gullak/data/model/preference.dart';
import 'package:gullak/data/creators.dart';
import 'package:provider/provider.dart';

import 'model/user.dart';

class Providers extends StatelessWidget {
  final Widget child;

  const Providers({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<User?>(
            create: (context) => getLogInUser(), initialData: null),
        FutureProvider<AppPreference>(
            create: (context) => getAppPreferences(),
            initialData: AppPreference(ThemeMode.dark))
      ],
      child: child,
    );
  }
}
