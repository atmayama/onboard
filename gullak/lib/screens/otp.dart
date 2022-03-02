import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gullak/components/buttons.dart';
import 'package:gullak/data/appState.dart';
import 'package:gullak/external/local/user.dart';
import 'package:gullak/external/network/api.dart';
import 'package:provider/provider.dart';

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
                otpForm(context),
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
          SimpleNavigationButton(
              onPressed: () {
                verify(context);
              },
              text: "VERIFY")
        ],
      )),
    );
  }

  Widget otpForm(BuildContext context) {
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

  void verify(BuildContext context) {
    if (_otpEditingController.value.text.isNotEmpty) {
      stdout.writeln(
          widget.registrationId + " " + _otpEditingController.value.text);
      verifyOtp(widget.registrationId, _otpEditingController.value.text)
          .then((value) {
        stdout.write(value);
        if (value == null) {
          Fluttertoast.showToast(
              msg: "Authentication Failed, Please try again");
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(msg: "Success");
          setUserId(value['userId']).then((value) {
            stdout.write('done');

            Navigator.of(context).popUntil((route) => false);
            Navigator.of(context).pushNamed("/");
            Provider.of<AppState>(context, listen: false).refresh();
          }).catchError((error) {
            stdout.write(error.toString());
            return null;
          });
        }
      }).catchError((error) => null);
    } else {
      Fluttertoast.showToast(msg: 'OTP is a 6 digit Number, try again');
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
