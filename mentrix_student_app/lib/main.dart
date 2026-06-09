import 'package:flutter/material.dart';
import 'screens/question_screen.dart';

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

// SUBJECT LIST PAGE
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChapterListPage(
                      examType: examType,
                      subjectName: subject['name'] as String,
                    ),
                  ),
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

// CHAPTER LIST PAGE
class ChapterListPage extends StatelessWidget {
  final String examType;
  final String subjectName;

  const ChapterListPage({
    Key? key,
    required this.examType,
    required this.subjectName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock chapters data
    final chapters = [
      {'id': 1, 'name': 'Chapter 1: Introduction'},
      {'id': 2, 'name': 'Chapter 2: Basics'},
      {'id': 3, 'name': 'Chapter 3: Advanced Concepts'},
      {'id': 4, 'name': 'Chapter 4: Applications'},
      {'id': 5, 'name': 'Chapter 5: Practice Problems'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(subjectName),
        backgroundColor: const Color(0xFF5B4EE8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: chapters.length,
          itemBuilder: (context, index) {
            final chapter = chapters[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ChapterCard(
                name: chapter['name'] as String,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopicListPage(
                        examType: examType,
                        subjectName: subjectName,
                        chapterName: chapter['name'] as String,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChapterCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const ChapterCard({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.orange, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(Icons.arrow_forward, color: Colors.orange),
          ],
        ),
      ),
    );
  }
}

// TOPIC LIST PAGE
class TopicListPage extends StatelessWidget {
  final String examType;
  final String subjectName;
  final String chapterName;

  const TopicListPage({
    Key? key,
    required this.examType,
    required this.subjectName,
    required this.chapterName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock topics data
    final topics = [
      {'id': 1, 'name': 'Topic 1.1: Basic Concepts'},
      {'id': 2, 'name': 'Topic 1.2: Key Definitions'},
      {'id': 3, 'name': 'Topic 1.3: Formulas & Theorems'},
      {'id': 4, 'name': 'Topic 1.4: Problem Solving'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(chapterName),
        backgroundColor: const Color(0xFF5B4EE8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: topics.length,
          itemBuilder: (context, index) {
            final topic = topics[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TopicCard(
                name: topic['name'] as String,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SubtopicListPage(
                        examType: examType,
                        subjectName: subjectName,
                        chapterName: chapterName,
                        topicName: topic['name'] as String,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class TopicCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const TopicCard({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(Icons.arrow_forward, color: Colors.green),
          ],
        ),
      ),
    );
  }
}

// SUBTOPIC LIST PAGE
class SubtopicListPage extends StatelessWidget {
  final String examType;
  final String subjectName;
  final String chapterName;
  final String topicName;

  const SubtopicListPage({
    Key? key,
    required this.examType,
    required this.subjectName,
    required this.chapterName,
    required this.topicName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock subtopics data
    final subtopics = [
      {'id': 1, 'name': 'Subtopic 1.1.1', 'questions': 12},
      {'id': 2, 'name': 'Subtopic 1.1.2', 'questions': 15},
      {'id': 3, 'name': 'Subtopic 1.1.3', 'questions': 18},
      {'id': 4, 'name': 'Subtopic 1.1.4', 'questions': 20},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(topicName),
        backgroundColor: const Color(0xFF5B4EE8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: subtopics.length,
          itemBuilder: (context, index) {
            final subtopic = subtopics[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SubtopicCard(
                name: subtopic['name'] as String,
                questions: subtopic['questions'] as int,
                onTap: () {
                  // Navigate to QuestionScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionScreen(
                        examType: examType,
                        isTestSeries: false,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class SubtopicCard extends StatelessWidget {
  final String name;
  final int questions;
  final VoidCallback onTap;

  const SubtopicCard({
    Key? key,
    required this.name,
    required this.questions,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.purple[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.purple, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$questions Questions',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward, color: Colors.purple),
          ],
        ),
      ),
    );
  }
}
