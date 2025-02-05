import 'package:flutter/material.dart';

class StockCard extends StatelessWidget {
  final String name;
  final String price;
  final String change;

  const StockCard({super.key, required this.name, required this.price, required this.change});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("₹$price USD "),
        trailing: Text(
          change,
          style: TextStyle(
            color: change.contains('-') ? Colors.red : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
