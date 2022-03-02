import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gullak/data/appState.dart';
import 'package:gullak/data/model/preference.dart';
import 'package:gullak/data/creators.dart';
import 'package:provider/provider.dart';

import 'model/user.dart';

class Providers extends StatefulWidget {
  final Widget child;

  const Providers({Key? key, required this.child}) : super(key: key);

  @override
  State<Providers> createState() => _ProvidersState();
}

class _ProvidersState extends State<Providers> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (context) => AppState())
      ],
      child: widget.child,
    );
  }
}
