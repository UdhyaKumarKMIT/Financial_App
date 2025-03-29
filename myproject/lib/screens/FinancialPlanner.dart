import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class FinancialPlannerScreen extends StatefulWidget {
  const FinancialPlannerScreen({super.key});

  @override
  _FinancialPlannerScreenState createState() => _FinancialPlannerScreenState();
}

class _FinancialPlannerScreenState extends State<FinancialPlannerScreen> {
  final Map<String, TextEditingController> controllers = {
    "Income": TextEditingController(),
    "Expenses": TextEditingController(),
    "Savings": TextEditingController(),
    "Debt Payments": TextEditingController(),
  };

  String selectedMonth = DateFormat('MMMM yyyy').format(DateTime.now());
  List<String> months = List.generate(12, (index) =>
      DateFormat('MMMM yyyy').format(DateTime(DateTime.now().year, index + 1)));

  double get totalIncome => double.tryParse(controllers["Income"]!.text) ?? 0;
  double get totalExpenses => double.tryParse(controllers["Expenses"]!.text) ?? 0;
  double get totalSavings => double.tryParse(controllers["Savings"]!.text) ?? 0;
  double get totalDebtPayments => double.tryParse(controllers["Debt Payments"]!.text) ?? 0;

  double get totalAmount => totalIncome + totalExpenses + totalSavings + totalDebtPayments;

  Widget _buildTextField(String label, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controllers[label],
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: color),
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: (value) => setState(() {}),
      ),
    );
  }

  Widget _buildChart() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Financial Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: totalAmount > 0
                      ? [
                          PieChartSectionData(color: Colors.green, value: totalIncome / totalAmount * 100, title: "Income"),
                          PieChartSectionData(color: Colors.red, value: totalExpenses / totalAmount * 100, title: "Expenses"),
                          PieChartSectionData(color: Colors.blue, value: totalSavings / totalAmount * 100, title: "Savings"),
                          PieChartSectionData(color: Colors.orange, value: totalDebtPayments / totalAmount * 100, title: "Debt"),
                        ]
                      : [],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("📊 Financial Planner"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text("Select Month", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedMonth,
                      items: months.map((month) {
                        return DropdownMenuItem(value: month, child: Text(month));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedMonth = value!;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text("Enter Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    _buildTextField("Income", Icons.attach_money, Colors.green),
                    _buildTextField("Expenses", Icons.money_off, Colors.red),
                    _buildTextField("Savings", Icons.savings, Colors.blue),
                    _buildTextField("Debt Payments", Icons.credit_card, Colors.orange),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildChart(),
          ],
        ),
      ),
    );
  }
}
