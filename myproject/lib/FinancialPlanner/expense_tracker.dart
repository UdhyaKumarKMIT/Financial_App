import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class ExpenseTrackerPage extends StatefulWidget {
  const ExpenseTrackerPage({super.key});

  @override
  _ExpenseTrackerPageState createState() => _ExpenseTrackerPageState();
}

class _ExpenseTrackerPageState extends State<ExpenseTrackerPage> {
  final List<Map<String, dynamic>> _expenses = [];
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String _selectedCategory = 'Food';
  double _totalExpense = 0.0;

  final List<String> _categories = ['Food', 'Transport', 'Bills', 'Shopping', 'Other'];

  void _addExpense() {
    double amount = double.tryParse(_amountController.text) ?? 0.0;
    if (amount > 0 && _descController.text.isNotEmpty) {
      setState(() {
        _expenses.add({
          'amount': amount,
          'description': _descController.text,
          'category': _selectedCategory,
          'date': DateTime.now(),
        });
        _totalExpense += amount;
        _amountController.clear();
        _descController.clear();
      });
    }
  }

  Map<String, double> _getCategoryWiseSpending() {
    Map<String, double> categoryExpenses = {};
    for (var expense in _expenses) {
      categoryExpenses[expense['category']] =
          (categoryExpenses[expense['category']] ?? 0.0) + expense['amount'];
    }
    return categoryExpenses;
  }

  List<PieChartSectionData> _getPieChartData() {
    Map<String, double> categoryExpenses = _getCategoryWiseSpending();
    return categoryExpenses.entries.map((entry) {
      return PieChartSectionData(
        title: '${entry.key}\n₹${entry.value.toStringAsFixed(2)}',
        value: entry.value,
        color: _getCategoryColor(entry.key),
        radius: 50,
        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.blue;
      case 'Transport':
        return Colors.green;
      case 'Bills':
        return Colors.red;
      case 'Shopping':
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: const Text('Expense Tracker'),
      backgroundColor: Colors.blueAccent,),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard when tapping outside
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expense Summary
              Text('Total Expenses: ₹${_totalExpense.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              // Pie Chart for Expense Breakdown
              if (_expenses.isNotEmpty)
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: _getPieChartData(),
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),

              const SizedBox(height: 10),

              // Expense Input Fields
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.money),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 10),

              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories
                    .map((category) => DropdownMenuItem(value: category, child: Text(category)))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 10),

              // Add Expense Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Expense'),
                  onPressed: _addExpense,
                ),
              ),

              const SizedBox(height: 20),

              // Expense List
              const Text('Expense History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Expanded(
                child: ListView.builder(
                  itemCount: _expenses.length,
                  itemBuilder: (context, index) {
                    var expense = _expenses[index];
                    String formattedDate = DateFormat('yyyy-MM-dd').format(expense['date']);
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.attach_money, color: _getCategoryColor(expense['category'])),
                        title: Text(expense['description']),
                        subtitle: Text('${expense['category']} - ₹${expense['amount'].toStringAsFixed(2)}\n$formattedDate'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _totalExpense -= expense['amount'];
                              _expenses.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
