import 'package:flutter/material.dart';

class EmergencyFundPage extends StatefulWidget {
  const EmergencyFundPage({super.key});

  @override
  _EmergencyFundPageState createState() => _EmergencyFundPageState();
}

class _EmergencyFundPageState extends State<EmergencyFundPage> {
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _savedController = TextEditingController();
  final List<Map<String, dynamic>> _transactions = [];
  double _goal = 1000; // Default goal
  double _saved = 0; // Default saved amount

  void _updateFund() {
    double? newGoal = double.tryParse(_goalController.text);
    double? newSaved = double.tryParse(_savedController.text);

    if (newGoal == null || newSaved == null || newGoal <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid numbers')),
      );
      return;
    }

    setState(() {
      _goal = newGoal;
      _saved = newSaved;
    });
  }

  void _addTransaction(bool isDeposit) {
    double? amount = double.tryParse(_savedController.text);
    if (amount == null || amount <= 0) return;

    setState(() {
      if (isDeposit) {
        _saved += amount;
      } else {
        _saved -= amount;
      }

      _transactions.insert(
        0,
        {
          'amount': amount,
          'type': isDeposit ? 'Deposit' : 'Withdrawal',
          'date': DateTime.now().toString().split(' ')[0],
        },
      );
    });

    _savedController.clear();
    _updateFund();
  }

  double _getProgress() {
    return (_saved / _goal).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Fund Planner')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Set Your Emergency Fund Goal',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _goalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Target Amount (\$)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.flag),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _savedController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount (\$)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _addTransaction(true),
                    child: const Text('Deposit'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _addTransaction(false),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Withdraw'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: _getProgress(),
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
            const SizedBox(height: 5),
            Text(
              'Saved: \$${_saved.toStringAsFixed(2)} / \$${_goal.toStringAsFixed(2)} (${(_getProgress() * 100).toStringAsFixed(1)}%)',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
