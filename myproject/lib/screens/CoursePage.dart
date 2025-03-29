import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final List<Map<String, String>> _courses = [
    {'title': 'Personal Finance Mastery', 'description': 'Learn budgeting, saving, and smart spending.', 'link': 'https://www.coursera.org/learn/family-planning'},
    {'title': 'Investing for Beginners', 'description': 'Covers stocks, bonds, mutual funds, and ETFs.', 'link': 'https://www.coursera.org/specializations/investment-portolio-management'},
    {'title': 'Stock Market 101', 'description': 'Fundamentals of trading and investing.', 'link': 'https://www.coursera.org/projects/construct-stock-market-indices'},
    {'title': 'Wealth Management', 'description': 'Managing assets, risk, and long-term financial planning.', 'link': 'https://www.coursera.org/learn/careers-in-financial-planning-and-wealth-management'},
    {'title': 'Financial Risk Management', 'description': 'Assess and mitigate financial risks.', 'link': 'https://www.coursera.org/learn/financial-risk-management-with-r'},
    {'title': 'Cryptocurrency and Blockchain', 'description': 'Understanding digital currencies and decentralized finance.', 'link': 'https://www.coursera.org/learn/wharton-cryptocurrency-blockchain-introduction-digital-currency'},
    {'title': 'Corporate Finance Fundamentals', 'description': 'Essential principles of corporate finance.', 'link': 'https://www.coursera.org/learn/corporate-finance-fundamentals'},
    {'title': 'Retirement Planning Strategies', 'description': 'Plan your financial future effectively.', 'link': 'https://www.coursera.org/learn/financial-planning'},
    {'title': 'Behavioral Finance', 'description': 'Understand psychology behind financial decisions.', 'link': 'https://www.coursera.org/learn/duke-behavioral-finance'},
    {'title': 'Economics of Money and Banking', 'description': 'Comprehensive study on banking systems.', 'link': 'https://www.coursera.org/learn/money-banking'},
  ];

  List<Map<String, String>> _filteredCourses = [];

  @override
  void initState() {
    super.initState();
    _filteredCourses = _courses;
  }

  void _filterCourses(String query) {
    setState(() {
      _filteredCourses = query.isEmpty
          ? _courses
          : _courses.where((course) => course['title']!.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Finance Courses', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 81, 104, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search courses...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: _filterCourses,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredCourses.length,
                itemBuilder: (context, index) {
                  var course = _filteredCourses[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(20),
                      title: Text(course['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      subtitle: Text(course['description']!, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseDetailPage(course: course),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final Map<String, String> course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(course['title']!),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(course['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 10),
              Text(course['description']!, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    Uri url = Uri.parse(course['link']!);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Could not open course link")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Go to Course', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
