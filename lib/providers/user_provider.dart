// ignore_for_file: prefer_const_declarations, always_specify_types, unused_element

import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider {
  static final String _baseUrl = 'api.savaexpress.us';

  Future<String> _getJsonData(String segment) async {
    var url = Uri.https(_baseUrl, segment);
    final response = await http.get(url);
    return response.body;
  }

  static loginUser(String correo, String password) async {
    const String segment = '/auth';
    var url = Uri.https(_baseUrl, segment);
    final body = {"correo": correo, "password": password};
    final jsonString = json.encode(body);
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: jsonString);
    print(response.body);
    final jsonDecoded = json.decode(response.body);
    return jsonDecoded;
  }

  static createUser(String phone, String correo, String password) async {
    const String segment = '/users/client';
    var url = Uri.https(_baseUrl, segment);
    final body = {"correo": correo, "telefono": phone, "password": password};
    final jsonString = json.encode(body);
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: jsonString);
    final jsonDecoded = json.decode(response.body);
    jsonDecoded['status'] = response.statusCode;
    return jsonDecoded;
  }
}
