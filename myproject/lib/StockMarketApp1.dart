import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  static const String apiKey = "C1HRSweTniWdBuLmTTse9w8KpkoiouM5"; // FinancialModelingPrep API Key
  static const String baseUrl = "https://financialmodelingprep.com/api/v3/quote/";
  final List<String> stocks = ["AAPL", "MSFT", "GOOGL", "TSLA", "NVDA"];
  List<Map<String, dynamic>> stockData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStockData();
  }

  Future<void> fetchStockData() async {
    List<Map<String, dynamic>> newStockData = [];
    for (String stock in stocks) {
      final response = await http.get(Uri.parse("$baseUrl$stock?apikey=$apiKey"));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          newStockData.add(data[0]);
        }
      }
    }
    setState(() {
      stockData = newStockData;
      isLoading = false;
    });
  }

  void showStockDetails(BuildContext context, Map<String, dynamic> stock) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(stock["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Symbol: ${stock["symbol"]}"),
              Text("Price: \$${stock["price"].toStringAsFixed(2)}"),
              Text("Change: ${stock["change"].toStringAsFixed(2)}"),
              Text("Change %: ${stock["changesPercentage"].toStringAsFixed(2)}%"),
              Text("Day Low: \$${stock["dayLow"].toStringAsFixed(2)}"),
              Text("Day High: \$${stock["dayHigh"].toStringAsFixed(2)}"),
              Text("Year Low: \$${stock["yearLow"].toStringAsFixed(2)}"),
              Text("Year High: \$${stock["yearHigh"].toStringAsFixed(2)}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("📈 Trending Tech Stocks")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: stockData.length,
                itemBuilder: (context, index) {
                  final stock = stockData[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(stock["name"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      subtitle: Text(
                        "${stock["symbol"]} - \$${stock["price"].toStringAsFixed(2)}  (${stock["changesPercentage"].toStringAsFixed(2)}%)",
                        style: TextStyle(
                          fontSize: 16,
                          color: stock["changesPercentage"] > 0 ? Colors.green : Colors.red,
                        ),
                      ),
                      onTap: () => showStockDetails(context, stock),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
