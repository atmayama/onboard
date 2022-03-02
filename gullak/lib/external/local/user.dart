import 'dart:io';

import 'package:gullak/data/model/preference.dart';
import 'package:gullak/data/model/user.dart';
import 'package:localstore/localstore.dart';

Future<String?> getUserId() async {
  stdout.writeln("getting user id");
  var result =
      await Localstore.instance.collection("user").doc("default").get();
  stdout.writeln("result " + result.toString());
  return result?['id'];
}

Future<dynamic> setUserId(String? id) {
  return Localstore.instance.collection('user').doc("default").set({"id": id});
}
