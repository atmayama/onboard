import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gullak/components/buttons.dart';
import 'package:provider/provider.dart';

import '../data/model/user.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: checkAuth,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: mainContent(context)),
              SimpleNavigationButton(
                  onPressed: () => {Navigator.pushNamed(context, "/sign")},
                  text: "CHECK OUT"),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkAuth(context, user, child) {
    if ((user.mobile?.isNotEmpty ?? false) && user.verified) {
      Fluttertoast.showToast(msg: "Logging in as ${user.mobile}");
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      Fluttertoast.showToast(msg: "Welcome");
      return child ?? Container();
    }
    return const Placeholder();
  }

  Widget mainContent(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 80.0),
          child: Image(
            height: 320,
            image: AssetImage("images/intro.png"),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
            child: Text(
              "Savings, Rewarded",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        )
      ],
    );
  }
}
