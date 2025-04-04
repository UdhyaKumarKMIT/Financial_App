import 'package:flutter/material.dart';

class CrisisManagementPage extends StatefulWidget {
  const CrisisManagementPage({super.key});

  @override
  _CrisisManagementPageState createState() => _CrisisManagementPageState();
}

class _CrisisManagementPageState extends State<CrisisManagementPage> {
  final List<String> _steps = [
    'Assess your financial situation immediately.',
    'Cut unnecessary expenses and focus on essentials.',
    'Contact creditors to negotiate payment plans.',
    'Find alternative sources of income if necessary.',
    'Use emergency funds wisely.',
    'Seek financial advice from experts.',
  ];
  final List<bool> _checkedSteps = List.generate(6, (index) => false);

  final List<Map<String, String>> _contacts = [
    {'name': 'Bank Customer Support', 'number': '1800-123-456'},
    {'name': 'Financial Advisor', 'number': '9876-543-210'},
    {'name': 'Emergency Loan Provider', 'number': '1800-222-333'},
  ];

  final List<Map<String, String>> _faqs = [
    {
      'question': 'What should I do first in a financial crisis?',
      'answer': 'Analyze your income, expenses, and debts. Identify essential payments and cut unnecessary expenses.'
    },
    {
      'question': 'How can I get emergency financial help?',
      'answer': 'Reach out to banks for emergency loans, government relief programs, or seek help from family and friends.'
    },
    {
      'question': 'What if I can’t pay my loans?',
      'answer': 'Contact your lender immediately to negotiate lower payments or deferred plans.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crisis Management Plan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Title Section
            Text('Financial Crisis Action Plan',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            // Checklist Section
            Text('✔️ Crisis Preparedness Checklist',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            ..._steps.asMap().entries.map((entry) {
              int index = entry.key;
              String step = entry.value;
              return CheckboxListTile(
                title: Text(step),
                value: _checkedSteps[index],
                onChanged: (bool? value) {
                  setState(() {
                    _checkedSteps[index] = value!;
                  });
                },
              );
            }),

            SizedBox(height: 20),

            // Emergency Contacts Section
            Text('📞 Emergency Financial Contacts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Column(
              children: _contacts.map((contact) {
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.phone, color: Colors.green),
                    title: Text(contact['name']!),
                    subtitle: Text(contact['number']!),
                    trailing: IconButton(
                      icon: Icon(Icons.call, color: Colors.blue),
                      onPressed: () {
                        // Simulated Call Action (Replace with real call logic)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Calling ${contact['name']}...')),
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 20),

            // FAQ Section
            Text('❓ Frequently Asked Questions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Column(
              children: _faqs.map((faq) {
                return ExpansionTile(
                  leading: Icon(Icons.help_outline, color: Colors.orange),
                  title: Text(faq['question']!,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(faq['answer']!),
                    )
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
