import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = 'https://api.polygon.io/v2'; // Example of a free stock API
const String apiKey = '	nouWsU6RMLQGvHoZ5QuL2OEFrdAjYQmw'; // Replace with a valid API key from a free stock API provider

Future<Map<String, dynamic>> fetchLTPData(String instrumentIdentifier) async {
  final url = '$baseUrl/last/trade/$instrumentIdentifier?apiKey=$apiKey';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('LTP Data for $instrumentIdentifier: $data');
      return data;
    } else {
      print('Error fetching LTP for $instrumentIdentifier: HTTP ${response.statusCode}');
      return {};
    }
  } catch (e) {
    print('Error fetching LTP for $instrumentIdentifier: $e');
    return {};
  }
}

Future<List<String>> getAllInstrumentIdentifiers() async {
  final url = 'https://finnhub.io/api/v1/stock/symbol?exchange=US&token=YOUR_FREE_API_KEY'; // Example API

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => item['symbol'].toString()).toList();
    } else {
      print('Error fetching instrument identifiers: HTTP ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error fetching instrument identifiers: $e');
    return [];
  }
}
