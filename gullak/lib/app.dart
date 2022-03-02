import 'package:flutter/material.dart';
import 'package:gullak/screens/home.dart';
import 'package:gullak/screens/intro.dart';
import 'package:gullak/screens/sign.dart';
import 'package:gullak/theme/theme.dart';

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
    return MaterialApp(
      title: 'Gullak App',
      debugShowCheckedModeBanner: false,
      routes: {
        "/sign": (context) => const Sign(),
        "/home": (context) => const Home(title: 'Gullak')
      },
      theme: dark,
      home: const Intro(),
    );
  }
}
