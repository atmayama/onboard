import 'package:flutter/material.dart';
import 'package:gullak/data/appState.dart';
import 'package:gullak/data/model/user.dart';
import 'package:gullak/external/local/user.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final User user;

  const Home({Key? key, required this.title, required this.user})
      : super(key: key);

  final String title;

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gullak"),
      ),
      body: Center(
        child: Text(
          "Welcome " + widget.user.id.toString(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _logout,
        child: const Icon(Icons.outbond),
      ),
    );
  }

  void _logout() {
    setUserId(null).then((value) {
      // Navigator.of(context).popUntil((_) => false);
      // Navigator.of(context).pushNamed("/");
      Provider.of<AppState>(context, listen: false).refresh();
    }).catchError((error) => null);
  }
}
