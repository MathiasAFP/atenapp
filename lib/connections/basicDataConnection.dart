import 'dart:convert';
import 'package:Atena/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Atena/connections/credentialConnection.dart';

Future<Map<String, dynamic>> getUserBasicDataConnection() async {
  try {
    final jwtToken = await getToken();
    final url = Uri.parse("$baseUrl/basicdata/userbasicdata");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $jwtToken'},
      body: jsonEncode({}),
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return body['message'] ?? {}; 
    } 
    else if (res.statusCode == 401 || res.statusCode == 403) {
      
      await deleteToken(); 

      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/login', (Route<dynamic> route) => false);
      
      return {}; 
    }
    else {
      print("Erro HTTP: ${res.statusCode}");
      return {};
    }
  } catch (error) {
    print("Erro em getUserBasicDataConnection: $error");
    return {};
  }
}

Future<Map<String, dynamic>> generalBasicDataConnection() async {
  try {
    final jwtToken = await getToken();
    final url = Uri.parse("$baseUrl/basicdata/generalbasicdata");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $jwtToken'},
      body: jsonEncode({}),
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return body['message'] ?? {}; 
    } 
    else if (res.statusCode == 401 || res.statusCode == 403) {
      
      await deleteToken(); 

      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/login', (Route<dynamic> route) => false);
      
      return {}; 
    }
    else {
      print("Erro HTTP: ${res.statusCode}");
      return {};
    }
  } catch (error) {
    print("Erro em getUserBasicDataConnection: $error");
    return {};
  }
}