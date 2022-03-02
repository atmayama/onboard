import 'package:flutter/material.dart';

class SimpleNavigationButton extends StatelessWidget {
  final void Function() onPressed;

  final String text;

  final bool enabled;

  const SimpleNavigationButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
      onPressed: onPressed,
      style: ButtonStyle(
        alignment: Alignment.center,
        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
      ),
    );
  }
}
