import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MentrixApp());
}

class MentrixApp extends StatelessWidget {
  const MentrixApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mentrix',
      theme: ThemeData(
        primaryColor: const Color(0xFF5B4EE8),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exams = [
      {'name': 'WBCHSE', 'icon': '📋', 'color': Colors.blue},
      {'name': 'NEET', 'icon': '🏥', 'color': Colors.green},
      {'name': 'JEE Mains', 'icon': '🔬', 'color': Colors.orange},
      {'name': 'WBJEE', 'icon': '🎯', 'color': Colors.purple},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mentrix'),
        backgroundColor: const Color(0xFF5B4EE8),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              color: const Color(0xFFF0F0FF),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Master Your Exams',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Practice MCQs, Take Tests & Track Progress',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B4EE8),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    onPressed: () {},
                    child: const Text('Get Started'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            
            // Exam Selection
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Your Exam',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: exams.length,
                    itemBuilder: (context, index) {
                      final exam = exams[index];
                      return ExamCard(
                        name: exam['name'] as String,
                        icon: exam['icon'] as String,
                        color: exam['color'] as Color,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubjectListPage(
                                examType: exam['name'] as String,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            // Banner Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green, width: 2),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.star, color: Colors.green),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'New Feature: Answer Keys for WBCHSE are LIVE!',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExamCard extends StatelessWidget {
  final String name;
  final String icon;
  final Color color;
  final VoidCallback onTap;

  const ExamCard({
    Key? key,
    required this.name,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectListPage extends StatelessWidget {
  final String examType;

  const SubjectListPage({Key? key, required this.examType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subjects = [
      {'name': 'Physics', 'icon': '⚡'},
      {'name': 'Chemistry', 'icon': '⚗️'},
      {'name': 'Biology', 'icon': '🌿'},
      {'name': 'Mathematics', 'icon': '🔢'},
      {'name': 'History', 'icon': '📜'},
      {'name': 'Geography', 'icon': '🌍'},
      {'name': 'Bengali', 'icon': '📖'},
      {'name': 'English', 'icon': '🔤'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(examType),
        backgroundColor: const Color(0xFF5B4EE8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.2,
          ),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return SubjectCard(
              name: subject['name'] as String,
              icon: subject['icon'] as String,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Loading ${subject['name']} chapters...')),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String name;
  final String icon;
  final VoidCallback onTap;

  const SubjectCard({
    Key? key,
    required this.name,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
      