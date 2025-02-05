import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';

// ignore: must_be_immutable
class HistoryPage extends StatelessWidget {
  final List<String> purchaseHistory;

  HistoryPage({required this.purchaseHistory});

  List<Map<String, dynamic>> options = [
    {'title': 'Market', 'icon': Icons.bar_chart},
    {'title': 'Trade', 'icon': Icons.show_chart},
    {'title': 'History', 'icon': Icons.history},
    {'title': 'Profile', 'icon': Icons.account_circle_outlined},
    {'title': 'About', 'icon': Icons.info},
    {'title': 'Logout', 'icon': Icons.logout},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 19, 23),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'History',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: DrawerWidget(
        options: options,
        onOptionSelected: (context, option) {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Purchase History',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: purchaseHistory.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      purchaseHistory[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}