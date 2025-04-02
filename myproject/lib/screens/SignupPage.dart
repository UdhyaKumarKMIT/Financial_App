import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20), // Fixed spacing
              Column(
                children: <Widget>[
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1200),
                    child: Text(
                      "Create an account, It's free",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30), // Fixed spacing
              Column(
                children: <Widget>[
                  FadeInUp(duration: const Duration(milliseconds: 1200), child: makeInput(label: "Email")),
                  FadeInUp(duration: const Duration(milliseconds: 1300), child: makeInput(label: "Password", obscureText: true)),
                  FadeInUp(duration: const Duration(milliseconds: 1400), child: makeInput(label: "Confirm Password", obscureText: true)),
                ],
              ),
              const SizedBox(height: 20), // Fixed button spacing
              FadeInUp(
                duration: const Duration(milliseconds: 1500),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black),
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 50, // Adjusted height
                    onPressed: () {},
                    color: Colors.greenAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Fixed spacing before text
              FadeInUp(
                duration: const Duration(milliseconds: 1600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Navigate back to Login
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30), // Ensure no overflow issues
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({required String label, bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(height: 5),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400)),
            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
        ),
        const SizedBox(height: 20), // Adjusted spacing to prevent overflow
      ],
    );
  }
}
