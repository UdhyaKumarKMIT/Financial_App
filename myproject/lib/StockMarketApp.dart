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
  static const String apiKey = "YG2ZQTO52LG58VEA"; // Replace with your API Key
  static const String baseUrl = "https://www.alphavantage.co/query";
  final List<String> stocks = ["AAPL", "MSFT", "GOOGL", "TSLA", "NVDA"];

  Map<String, double> stockPrices = {};
  Map<String, double> stockChanges = {};
  Map<String, double> stockOpen = {};
  Map<String, double> stockHigh = {};
  Map<String, double> stockLow = {};

  Timer? timer;

  @override
  void initState() {
    super.initState();
    fetchStockPrices();
    timer = Timer.periodic(const Duration(seconds: 30), (Timer t) => fetchStockPrices()); // Auto-refresh every 30 seconds
  }

  Future<void> fetchStockPrices() async {
    for (String stock in stocks) {
      final response = await http.get(Uri.parse("$baseUrl?function=GLOBAL_QUOTE&symbol=$stock&apikey=$apiKey"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final quote = data["Global Quote"];

        setState(() {
          stockPrices[stock] = double.tryParse(quote["05. price"]) ?? 0.0;
          stockChanges[stock] = double.tryParse(quote["10. change percent"]?.replaceAll("%", "")) ?? 0.0;
          stockOpen[stock] = double.tryParse(quote["02. open"]) ?? 0.0;
          stockHigh[stock] = double.tryParse(quote["03. high"]) ?? 0.0;
          stockLow[stock] = double.tryParse(quote["04. low"]) ?? 0.0;
        });
      }
    }
  }

  void showStockDetails(String stock) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("$stock Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Current Price: \$${stockPrices[stock]?.toStringAsFixed(2) ?? "N/A"}"),
              Text("Open: \$${stockOpen[stock]?.toStringAsFixed(2) ?? "N/A"}"),
              Text("High: \$${stockHigh[stock]?.toStringAsFixed(2) ?? "N/A"}"),
              Text("Low: \$${stockLow[stock]?.toStringAsFixed(2) ?? "N/A"}"),
              Text("Change: ${stockChanges[stock] != null ? stockChanges[stock]!.toStringAsFixed(2) : "N/A"}%"),
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
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("📈 Trending Tech Stocks"),
        backgroundColor: Colors.blueAccent,
      ), 
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
                subtitle: stockPrices.containsKey(stock)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("\$${stockPrices[stock]!.toStringAsFixed(2)}",
                              style: const TextStyle(fontSize: 16, color: Colors.green)),
                          Text(
                            "${stockChanges[stock] != null ? stockChanges[stock]!.toStringAsFixed(2) : "0.00"}%",
                            style: TextStyle(
                                fontSize: 14,
                                color: (stockChanges[stock] ?? 0) >= 0 ? Colors.green : Colors.red),
                          ),
                        ],
                      )
                    : const Text("Loading..."),
                onTap: () => showStockDetails(stock),
              ),
            );
          },
        ),
      ),
    );
  }
}
