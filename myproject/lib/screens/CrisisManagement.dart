import 'package:flutter/material.dart';
import '../FinancialPlanner/emergency_fund.dart';
import '../FinancialPlanner/crisis_management.dart';


class CrisisManagement extends StatelessWidget {
  const CrisisManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Financial Crisis Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Financial Crisis Planner'),
        backgroundColor: Colors.blueAccent,
      ),      
     
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MenuButton(
              title: "Emergency Fund Planner",
              icon: Icons.savings,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmergencyFundPage()),
              ),
            ),
            MenuButton(
              title: "Crisis Management",
              icon: Icons.warning,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CrisisManagementPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MenuButton({super.key, required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blue),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
