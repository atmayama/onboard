import 'package:gullak/data/model/preference.dart';
import 'package:localstore/localstore.dart';

class User {
  int? id;
  bool verified = false;
  String? mobile;

  User();

  User.from(this.id, this.mobile, this.verified);

  @override
  String toString() {
    return 'User{id: $id, verified: $verified, mobile: $mobile}';
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "mobile": mobile, "verified": verified};
  }

  User.fromMap(Map<String, dynamic>? map) {
    if (map != null) {
      id = map['id'];
      mobile = map['mobile'];
      verified = map['verified'];
    }
  }
}
