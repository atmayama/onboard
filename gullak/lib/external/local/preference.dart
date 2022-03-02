import 'package:gullak/data/model/preference.dart';
import 'package:localstore/localstore.dart';

Future<AppPreference> getPreference() async {
  return AppPreference.fromMap(
      await Localstore.instance.collection("preference").doc("default").get());
}

setPreference(AppPreference appPreference) {
  return Localstore.instance
      .collection('preference')
      .doc("default")
      .set({"theme": appPreference.theme.toString()});
}
