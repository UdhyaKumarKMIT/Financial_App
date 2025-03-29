import 'package:flutter/material.dart';
import 'stock_card.dart';
import 'stock_service.dart';

class StockListScreen extends StatefulWidget {
  const StockListScreen({super.key});

  @override
  _StockListScreenState createState() => _StockListScreenState();
}

class _StockListScreenState extends State<StockListScreen> {
  List<Map<String, dynamic>> stocks = [];

  @override
  void initState() {
    super.initState();
    fetchStockPrices();
  }

  Future<void> fetchStockPrices() async {
    List<String> stockSymbols = ["AAPL", "GOOGL", "TSLA"]; // Stock symbols

    List<Map<String, dynamic>> updatedStocks = [];

    for (String symbol in stockSymbols) {
      try {
        var stockData = await StockService.fetchStockPrice(symbol);
        updatedStocks.add(stockData);
      } catch (e) {
        print("Error fetching stock $symbol: $e");
      }
    }

    setState(() {
      stocks = updatedStocks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Real-Time Stock Prices")),
      body: stocks.isEmpty
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchStockPrices, // Pull to refresh stock prices
              child: ListView.builder(
                itemCount: stocks.length,
                itemBuilder: (context, index) {
                  return StockCard(
                    name: stocks[index]['name'],
                    price: stocks[index]['price'].toString(),
                    change: stocks[index]['change'].toString(),
                  );
                },
              ),
            ),
    );
  }
}
