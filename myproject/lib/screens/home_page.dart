import 'package:flutter/material.dart';
import 'package:myproject/screens/FinancialPlanner.dart';
import 'package:myproject/screens/ProfilePage.dart';
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
                    MaterialPageRoute(builder: (context) => CoursePage()));
                 },
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text("Course"),
              onTap: (){
                   Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CoursePage()));
                 },
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text("Financial Planneer"),
              onTap: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => FinancialPlannerScreen()));
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
      body: Center(child: Text("Swipe from left or tap top-left icon")),
    );
  }
}
