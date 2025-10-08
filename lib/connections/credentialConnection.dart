import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:http/browser_client.dart';


Future<int> SignUp(String name, String email, String password, String position) async {
  try {
    final url = Uri.parse("http://localhost:3000/signup");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password, 'position': position}),
    );

    return res.statusCode == 200 ? 200 : 500;
  } catch (e) {
    return 500;
  }
}

Future<int> Login(String name, String email, String password, String? position) async {
  try {
    final url = Uri.parse("http://localhost:3000/login");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password, if (position != null) 'position': position}),
    );

    if (res.statusCode == 200) {
      return 200;
    }
    if (res.statusCode == 201) {
      return 201;
    }
    if (res.statusCode == 202) {
      return 202;
    }
    return 500;
  } catch (e) {
    return 500;
  }
}