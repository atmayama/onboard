import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gullak/components/buttons.dart';

class Otp extends StatefulWidget {
  final String registrationId;

  const Otp({
    Key? key,
    required this.registrationId,
  }) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController _otpEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _formKey.currentState?.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text(
                  "Enter OTP",
                  style: Theme.of(context).textTheme.headline4,
                ),
                otpForm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CountDown(3),
                    TextButton(onPressed: () {}, child: Text("resend code"))
                  ],
                )
              ],
            ),
          )),
          SimpleNavigationButton(onPressed: verify, text: "VERIFY")
        ],
      )),
    );
  }

  Widget otpForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Form(
          key: _formKey,
          child: TextFormField(
            controller: _otpEditingController,
            autofocus: true,
            keyboardType: TextInputType.phone,
            style: Theme.of(context).textTheme.headline5,
            validator: (value) {
              if ((value?.length ?? 0) != 6) {
                return "OTP should be 6 digits";
              }
            },
            obscureText: true,
            textAlign: TextAlign.center,
            decoration: const InputDecoration.collapsed(
              hintText: 'OTP',
            ),
          )),
    );
  }

  void verify() {
    if (_otpEditingController.value.text == "123456") {
      Navigator.of(context).popUntil(ModalRoute.withName("/"));
    } else {
      Fluttertoast.showToast(msg: 'Wrong OTP, Please try again');
    }
  }
}

class CountDown extends StatefulWidget {
  final int minutes;

  const CountDown(this.minutes, {Key? key}) : super(key: key);

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<CountDown> {
  late final Timer _timer;
  late int secondsRemaining = 0;

  @override
  void initState() {
    secondsRemaining = widget.minutes * 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(secondsRemaining == 0
        ? "expired"
        : "${(secondsRemaining ~/ 60)}:${secondsRemaining % 60}");
  }
}
