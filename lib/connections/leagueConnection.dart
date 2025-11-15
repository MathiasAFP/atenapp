import 'dart:convert';
import 'package:Atena/main.dart';
import 'package:Atena/views/generalViews/userLoginView.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Atena/connections/credentialConnection.dart';

Future<List> getCompetitorsLeagueConnection() async {
  try {
    final jwtToken = await getToken();

    if (jwtToken == null || jwtToken.isEmpty) {
      return ["Erro: Usuário não autenticado. Faça login primeiro."];
    }

    final url = Uri.parse("$baseUrl/league/getcompetitorsleague");

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode({}),
    );

    final responseBody = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return responseBody['message'] ?? 'Requisição realizada com sucesso.';
    }
    else if (res.statusCode == 401 || res.statusCode == 403) {
      
      await deleteToken(); 

      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/login', (Route<dynamic> route) => false);
      
      return []; 
    }
    
    else {
      return responseBody['message'] ?? 'Erro na requisição.';
    }
  } catch (error) {
    return ["Erro inesperado: $error"];
  }
}