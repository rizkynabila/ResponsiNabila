import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseNetwork {
  static const String baseUrl = 'https://www.amiiboapi.com/';

  BaseNetwork(String s);
  static Future<List<dynamic>> getData(String endpoint) async {
    final response = await http.get(Uri.parse(baseUrl + endpoint));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data[endpoint] ?? [];
    } else {
      throw Exception("Gagal mengambil data!");
    }
  }

  static Future<Map<String, dynamic>> getDetailData(
      String endpoint, int id) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data[endpoint] ?? [];
    } else {
      throw Exception("Gagal mengambil data!");
    }
  }
}
