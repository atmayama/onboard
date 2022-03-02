import 'package:gullak/data/model/preference.dart';
import 'package:gullak/data/model/user.dart';
import 'package:localstore/localstore.dart';

Future<int> getUserId() async {
  return (await Localstore.instance
      .collection("user")
      .doc("default")
      .get())?['id'];
}

Future setUserId(int id) async {
  return Localstore.instance.collection('user').doc("default").set({"id": id});
}
