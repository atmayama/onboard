import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../data/model/user.dart';

String baseUrl = '192.168.0.100:8080';

var client = http.Client();

Future<User?> getUser(String id) async {
  var url = Uri.http(baseUrl, '/v1/user', {"id": id});
  var response = await client.get(url);
  stdout.write("response" + response.toString());
  if (response.statusCode != 200) return null;
  var user = jsonDecode(response.body);
  return User.from(id, user['phoneNumber'], true);
}

Future<Map> register(String phoneNumber) async {
  var url = Uri.http(baseUrl, '/v1/referral/generateOtp');
  var response = await client.post(url,
      headers: {"content-type": "application/json"},
      body: json.encode({"phoneNumber": phoneNumber}));
  stdout.writeln(response);
  var reg = jsonDecode(response.body);
  return reg;
}

Future<Map?> verifyOtp(String otpToken, String otp) async {
  var url = Uri.http(baseUrl, '/v1/referral/verifyOtp');
  var response = await client.post(url,
      headers: {"content-type": "application/json"},
      body: json.encode({"otpToken": otpToken, "otp": otp}));
  stdout.writeln(response.statusCode.toString() + response.body);
  if (response.statusCode != 200) return null;
  var res = jsonDecode(response.body);
  return res;
}
