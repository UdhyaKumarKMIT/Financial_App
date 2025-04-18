import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


class FinTherapistApp extends StatelessWidget {
  const FinTherapistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial Therapist',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: FinTherapistPage(),
    );
  }
}

class FinTherapistPage extends StatefulWidget {
  const FinTherapistPage({super.key});

  @override
  _FinTherapistPageState createState() => _FinTherapistPageState();
}

class _FinTherapistPageState extends State<FinTherapistPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  // 🔹 Replace with your actual API Key from Google AI Studio
  final String _apiKey = "AIzaSyAiT3MJ3hfV0KU7zBu5LhFtnFIRXAXXTSU";

  late GenerativeModel _model;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(model: "tunedModels/financial-therapist-931s6ara3nne", apiKey: _apiKey);
  }

  Future<String> _fetchTherapistResponse(String userMessage) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final chatSession = _model.startChat();
      final response = await chatSession.sendMessage(Content.text(userMessage));

      if (response.text != null) {
        return response.text!;
      } else {
        return "I want to understand more. Could you share more about your financial concerns?";
      }
    } catch (e) {
      print('Error: $e');
      return "Connection failed. Please check your internet and API key.";
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty && !_isLoading) {
      final userMessage = _controller.text;
      _controller.clear();

      setState(() {
        _messages.add({'sender': 'You', 'message': userMessage});
      });

      final therapistResponse = await _fetchTherapistResponse(userMessage);

      setState(() {
        _messages.add({'sender': 'Therapist', 'message': therapistResponse});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
          title: Text('Financial Therapist'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'You';

                return Container(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.teal[600] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['sender']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isUser ? Colors.white : Colors.teal[800],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          message['message']!,
                          style: TextStyle(
                            color: isUser ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: EdgeInsets.all(8),
              child: LinearProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Share your financial thoughts...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    maxLines: null,
                    onSubmitted: (text) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.teal),
                  onPressed: _isLoading ? null : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}