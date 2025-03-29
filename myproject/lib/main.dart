import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const StockMarketApp());
}

class StockMarketApp extends StatelessWidget {
  const StockMarketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock Market',
      theme: ThemeData.dark(),
      home: const StockMarketPage(),
    );
  }
}

class StockMarketPage extends StatefulWidget {
  const StockMarketPage({super.key});

  @override
  _StockMarketPageState createState() => _StockMarketPageState();
}

class _StockMarketPageState extends State<StockMarketPage> {
  static const String apiKey = "E22TMVIWMKZ8O2JZ"; // Replace with your API Key
  static const String baseUrl = "https://www.alphavantage.co/query";
  final List<String> stocks = ["AAPL", "MSFT", "GOOGL", "TSLA", "NVDA"];
  Map<String, double> stockPrices = {};
  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetchStockPrices();
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) => fetchStockPrices());
  }

  Future<void> fetchStockPrices() async {
    for (String stock in stocks) {
      final response = await http.get(Uri.parse("$baseUrl?function=GLOBAL_QUOTE&symbol=$stock&apikey=$apiKey"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          stockPrices[stock] = double.tryParse(data["Global Quote"]["05. price"]) ?? 0.0;
        });
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📈 Trending Tech Stocks")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: stocks.length,
          itemBuilder: (context, index) {
            String stock = stocks[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                title: Text(stock, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: Text(
                  stockPrices.containsKey(stock) ? "\$${stockPrices[stock]!.toStringAsFixed(2)}" : "Loading...",
                  style: TextStyle(
                    fontSize: 16,
                    color: stockPrices.containsKey(stock) && stockPrices[stock]! > 0 ? Colors.green : Colors.red,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
