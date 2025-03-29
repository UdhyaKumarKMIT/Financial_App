import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';
import '../screens/history_page.dart';

class TradePage extends StatefulWidget {
  const TradePage({super.key});

  @override
  _TradePageState createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  final List<Map<String, dynamic>> options = [
    {'title': 'Market', 'icon': Icons.bar_chart},
    {'title': 'Trade', 'icon': Icons.show_chart},
    {'title': 'History', 'icon': Icons.history},
    {'title': 'Profile', 'icon': Icons.account_circle_outlined},
    {'title': 'About', 'icon': Icons.info},
    {'title': 'Logout', 'icon': Icons.logout},
  ];

  void handleOptionSelection(BuildContext context, String option) {
    switch (option) {
      case 'History':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HistoryPage(purchaseHistory: []),
          ),
        );
        break;
      case 'Trade':
        break; // Already on TradePage
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid option: $option')),
        );
    }
  }

  final List<String> purchasedStocks = ['MGL-I', 'AAPL'];
  String? selectedStock;
  double purchasePrice = 0.0;
  double currentLTP = 0.0;

  @override
  void initState() {
    super.initState();
    if (purchasedStocks.isNotEmpty) {
      selectedStock = purchasedStocks.first;
      fetchStockData(selectedStock!);
    }
  }

  Future<void> fetchStockData(String stock) async {
    setState(() {
      purchasePrice = 100.0;
      currentLTP = 110.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 19, 23),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Trade', style: TextStyle(fontSize: 18, color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: DrawerWidget(
        options: options,
        onOptionSelected: handleOptionSelection,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedStock,
              items: purchasedStocks.map((stock) {
                return DropdownMenuItem<String>(
                  value: stock,
                  child: Text(stock, style: TextStyle(fontSize: 18, color: Colors.white)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedStock = value;
                    fetchStockData(selectedStock!);
                  });
                }
              },
              dropdownColor: Color.fromARGB(255, 17, 19, 23),
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text('Purchase Price: \$${purchasePrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, color: Colors.white)),
            SizedBox(height: 10),
            Text('Current LTP: \$${currentLTP.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, color: Colors.white)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text('BUY'),
            ),
          ],
        ),
      ),
    );
  }
}
