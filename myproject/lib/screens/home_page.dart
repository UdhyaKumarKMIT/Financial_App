import 'package:flutter/material.dart';
import 'package:myproject/screens/FinancialPlanner.dart';
import 'package:myproject/screens/ProfilePage.dart';
import '../FinancialPlanner/expense_tracker.dart';
import 'package:myproject/screens/ChatBotPage.dart';
import 'package:myproject/StockMarketApp.dart';

import 'package:myproject/screens/CrisisManagement.dart';

import 'package:myproject/screens/FinancialTherapist.dart';

import 'CoursePage.dart';
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stock Market")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.chat_bubble_outline),
              title: Text("Chat Bot"),
               onTap: (){
                   Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatBotPage()));
                 },
            ),ListTile(
  leading: Icon(Icons.psychology), // Changed from attach_money
  title: Text("Financial Therapist"),
  onTap: () {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => FinTherapistApp()));
  },
),    
ListTile(
  leading: Icon(Icons.school), // Suitable for courses
  title: Text("Course"),
  onTap: () {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => CoursePage()));
  },
),
ListTile(
  leading: Icon(Icons.calculate), // Changed from attach_money
  title: Text("Financial Planner"),
  onTap: () {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => FinancialPlannerScreen()));
  },
), 
ListTile(
  leading: Icon(Icons.bar_chart), // Changed from attach_money
  title: Text("Expense Tracker"),
  onTap: () {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => ExpenseTrackerPage()));
  },
),             
ListTile(
  leading: Icon(Icons.warning_amber), // Changed from attach_money
  title: Text("Crisis Manager"),
  onTap: () {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => CrisisManagement()));
  },
),

             ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: Text("Profile"),
              onTap: (){
            
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
             ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => FinancialPlannerScreen()));
              },
            ),
          ],
        ),
      ),
     body: StockMarketApp(),

    );
  }
}
