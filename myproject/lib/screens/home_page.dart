import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';
import '../services/api_service.dart';

import 'history_page.dart';
import 'trade_page.dart';
import 'about_page.dart';
import 'profile_page.dart';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> options = [
    {'title': 'Market', 'icon': Icons.bar_chart},
    {'title': 'Trade', 'icon': Icons.show_chart},
    {'title': 'History', 'icon': Icons.history},
    {'title': 'News', 'icon': Icons.info},
    {'title': 'Profile', 'icon': Icons.account_circle_outlined},
    {'title': 'About', 'icon': Icons.info},
    {'title': 'Logout', 'icon': Icons.logout},
  ];

  List<String> instrumentIdentifiers = ['MGL-I'];

  Map<String, dynamic> ltpValues = {};
  List<String> purchaseHistory = [];

  @override
  void initState() {
    super.initState();
    fetchLTP();
  }

  Future<void> fetchLTP() async {
    for (String identifier in instrumentIdentifiers) {
      final data = {
        "InstrumentIdentifier": identifier,
        "LastTradePrice": 23039.75
      };
      setState(() {
        ltpValues[identifier] = data['LastTradePrice'];
      });
    }
  }

  void handleOptionSelection(BuildContext context, String option) {
    switch (option) {
      case 'Market':
        setState(() => _selectedIndex = 0);
        break;
      case 'Trade':
        setState(() => _selectedIndex = 1);
        break;
      case 'History':
        setState(() => _selectedIndex = 2);
        break;
      case 'Profile':
        Navigator.pushNamed(context, '/profile');
        break;
      case 'About':
        Navigator.pushNamed(context, '/about');
        break;
      case 'Logout':
        break;
      default:
        print('Invalid option: $option');
    }
  }

  Future<void> buyStock(String instrumentIdentifier, double quantity) async {
    final lastTradePrice = ltpValues[instrumentIdentifier] ?? 0;
    if (lastTradePrice > 0) {
      final totalCost = lastTradePrice * quantity;
      final purchaseDetails =
          '$instrumentIdentifier - Quantity: $quantity - Total Cost: $totalCost INR';

      setState(() {
        purchaseHistory.add(purchaseDetails);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Purchase successful - $purchaseDetails')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to get the latest stock data.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget buildLTP(BuildContext context, String identifier) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Color.fromARGB(255, 17, 19, 23),
            ),
            child: ListTile(
              title: Text(
                identifier,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              subtitle: Text(
                'Last updated: ${DateTime.now()}',
                style: TextStyle(fontSize: 11, color: Colors.white),
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 5),
                  Text(
                    '+112.3(10.1%)',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${ltpValues[identifier] ?? 'N/A'}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            color: Colors.white,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage;
    switch (_selectedIndex) {
      case 0:
        currentPage = Scaffold(
          backgroundColor: Color.fromARGB(255, 17, 19, 23),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            title: Text(
              'Market',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.white),
                onPressed: fetchLTP,
              ),
            ],
          ),
          drawer: DrawerWidget(
            options: options,
            onOptionSelected: handleOptionSelection,
          ),
          body: ListView.builder(
            itemCount: instrumentIdentifiers.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  buildLTP(context, instrumentIdentifiers[index]),
                  SizedBox(height: 5),
                ],
              );
            },
          ),
        );
        break;
      case 1:
        currentPage = TradePage();
        break;
      case 2:
      currentPage = HistoryPage(purchaseHistory: purchaseHistory);
        break;
      default:
        currentPage = Container();
    }

    return Scaffold(
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 17, 19, 23),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Market'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Trade'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
      ),
    );
  }
}
