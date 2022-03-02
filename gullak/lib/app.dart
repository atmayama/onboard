import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gullak/data/appState.dart';
import 'package:gullak/screens/flash.dart';
import 'package:gullak/screens/home.dart';
import 'package:gullak/screens/intro.dart';
import 'package:gullak/screens/sign.dart';
import 'package:gullak/theme/theme.dart';
import 'package:provider/provider.dart';

import 'data/model/user.dart';
import 'data/providers.dart';

class GullakApp extends StatelessWidget {
  const GullakApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Base();
  }
}

class Base extends StatelessWidget {
  const Base({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Providers(child: Presentation());
  }
}

class Presentation extends StatelessWidget {
  const Presentation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, _) {
        return MaterialApp(
          title: 'Gullak App',
          debugShowCheckedModeBanner: false,
          routes: {
            "/sign": (context) => checkAuth(context, appState, const Sign()),
          },
          theme: dark,
          home: checkAuth(context, appState, const Intro()),
        );
      },
      child: const MaterialApp(
        home: FlashPage(),
      ),
    );
  }

  Widget checkAuth(context, AppState? state, child) {
    if (state == null) return child;
    if (state.user == null) return child;
    stdout.writeln(state.user.toString());
    if ((state.user?.mobile?.isNotEmpty ?? false) &&
        (state.user?.verified ?? false)) {
      Fluttertoast.showToast(msg: "Logging in as ${state.user?.mobile}");
      return Home(title: "Gullak", user: state.user ?? User());
    } else {
      Fluttertoast.showToast(msg: "Welcome");
      return child;
    }
  }
}
