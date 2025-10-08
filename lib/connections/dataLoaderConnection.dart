import 'dart:convert';
import 'package:http/browser_client.dart';
import 'credentialConnection.dart';
import 'package:http/http.dart' as http;

Future<String> UserBasicDataLoader() async {
  try {
    final url = Uri.parse('http://localhost:3000/dataloader/basicdata');

    final res = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode == 200) {
      final jsonData = jsonDecode(res.body);
      return jsonData['name'];
    } else {
      return "UserBasicDataLoaderConnectionError";
    }
  } catch (e) {
    return "UserBasicDataLoaderConnectionError";
  }
}