import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gullak/components/buttons.dart';
import 'package:gullak/screens/otp.dart';
import 'package:gullak/screens/terms.dart';

class Sign extends StatefulWidget {
  const Sign({Key? key}) : super(key: key);

  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  bool termsAgreed = false;
  String mobileNumber = "";

  final GlobalKey<FormState> _mobileNumberRef = GlobalKey<FormState>();
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: mainContent(context)),
            termsAndSubmit(context)
          ],
        ),
      ),
    );
  }

  Widget termsAndSubmit(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Checkbox(
                  value: termsAgreed,
                  onChanged: (newVal) {
                    setState(() {
                      termsAgreed = newVal ?? false;
                    });
                  }),
              const Expanded(
                  child:
                      Text("I have read and approve the terms and conditions")),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TermsAndConditions()));
                  },
                  icon: const Icon(Icons.open_in_new))
            ],
          ),
        ),
        SimpleNavigationButton(
            onPressed: () => signUp(context), text: "SUBMIT"),
      ],
    );
  }

  Padding mainContent(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Let's do this",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Text(
                "this only takes a minute",
                style: Theme.of(context).textTheme.headline6,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "+91",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Expanded(
                        child: Form(
                      key: _mobileNumberRef,
                      child: TextFormField(
                        controller: mobileController,
                        autofocus: false,
                        keyboardType: TextInputType.phone,
                        inputFormatters: mobileNumberInputFormatters,
                        style: Theme.of(context).textTheme.headline5,
                        validator: (value) {
                          if ((value?.length ?? 0) < 10) {
                            return "Mobile number should be 10 digits";
                          }
                        },
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Mobile Number',
                        ),
                      ),
                    ))
                  ]))
            ]));
  }

  List<TextInputFormatter> mobileNumberInputFormatters = [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
    LengthLimitingTextInputFormatter(10),
    TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.length > 7) {
        return TextEditingValue(
            selection:
                TextSelection.collapsed(offset: newValue.text.length + 4),
            text:
                "(${newValue.text.substring(0, 3)}) ${newValue.text.substring(3, 7)} ${newValue.text.substring(7)}");
      }
      if (newValue.text.length > 3) {
        return TextEditingValue(
            text:
                "(${newValue.text.substring(0, 3)}) ${newValue.text.substring(3)}",
            selection:
                TextSelection.collapsed(offset: newValue.text.length + 3));
      }
      return newValue;
    })
  ];

  void signUp(context) {
    FocusScope.of(context).unfocus();
    if (!termsAgreed) {
      Fluttertoast.showToast(msg: "Please read and approve T&C");
      return;
    }
    if (!(_mobileNumberRef.currentState?.validate() ?? false)) {
      Fluttertoast.showToast(msg: "Please input correct phone number");
      return;
    }
    String number =
        mobileController.value.text.replaceAll(RegExp("[^0-9]+"), "");
    Fluttertoast.showToast(msg: "Processing...");

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Otp(registrationId: number)));
  }
}
