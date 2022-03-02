import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../data/model/user.dart';

String baseUrl = '192.168.0.100:8080';

var client = http.Client();

Future<User> getUser(int id) async {
  var url = Uri.http(baseUrl, '/v1/user?id=$id');
  var response = await client.get(url);
  print(response);
  var user = jsonDecode(response.body);
  return User.from(id, user['phoneNumber'], true);
}

Future<User> register(String phoneNumber) async {
  var url = Uri.http(baseUrl, '/v1/referral/generateOtp');
  var response = await client.post(url, body: {"phoneNumber": phoneNumber});
  print(response);
  var user = jsonDecode(response.body);
  return User.from(user['id'], phoneNumber, true);
}
