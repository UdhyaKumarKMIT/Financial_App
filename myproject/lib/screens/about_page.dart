
import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';

class AboutPage extends StatelessWidget {
  final List<Map<String, dynamic>> options;

  AboutPage({required this.options});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 19, 23),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'About',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: DrawerWidget(
        options: options,
        onOptionSelected: (context, option) {},
      ),
      body: const Center(
        child: Text(
          'This is the About Page',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
