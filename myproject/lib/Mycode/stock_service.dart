import 'package:http/http.dart' as http;
import 'dart:convert';

class StockService {
  static const String apiKey = "E22TMVIWMKZ8O2JZ"; // Replace with your API Key
  static const String baseUrl = "https://www.alphavantage.co/query";

  static Future<Map<String, dynamic>> fetchStockPrice(String symbol) async {
    final url = "$baseUrl?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        return {
          'name': symbol,
          'price': data["Global Quote"]["05. price"],
          'change': data["Global Quote"]["10. change percent"]
        };
      } else {
        throw Exception("Failed to load stock data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
