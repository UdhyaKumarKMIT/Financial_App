import 'package:flutter/material.dart';
import 'screens/home_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Define the initial route as a string
      routes: {
        '/': (context) => const MyHomePage(),
       
        // Add more routes here
      },
    );
  }
}
