// ignore_for_file: always_specify_types, always_declare_return_types

import 'package:http/http.dart' as http;
import 'dart:convert';

class WarehousePackageProvider {
  static final String _baseUrl = 'api.savaexpress.us';

  static getWarehousePackages(String token) async {
    const String segment = '/api/warehouse-packages/user';
    var url = Uri.http(_baseUrl, segment);
    final response = await http.get(url,
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    final jsonDecoded = json.decode(response.body);
    return jsonDecoded;
  }

  static getSavaPackages(String token) async {
    const String segment = '/savaPackage/';
    var url = Uri.http(_baseUrl, segment);
    final response = await http.get(url,
        headers: {'Content-Type': 'application/json', 'Authorization': token});
    final jsonDecoded = json.decode(response.body);
    return jsonDecoded;
  }

  static createSavaPackages(packages) async {
    const String segment = "/api/warehouse/sava";
    var url = Uri.http(_baseUrl, segment);
    final body = {"packages": packages};
    final jsonString = json.encode(body);
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: jsonString);
    final jsonDecoded = json.decode(response.body);
    return jsonDecoded;
  }
}
