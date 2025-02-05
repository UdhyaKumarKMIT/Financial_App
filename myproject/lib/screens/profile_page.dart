import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';

class ProfilePage extends StatelessWidget {
  final List<Map<String, dynamic>> options;

  const ProfilePage({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 19, 23),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: DrawerWidget(
        options: options,
        onOptionSelected: (context, option) {
          Navigator.pop(context); // Close drawer when an option is selected
        },
      ),
      body: const Center(
        child: Text(
          'This is the Profile Page',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
